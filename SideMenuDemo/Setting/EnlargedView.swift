//
//  EnlargedView.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/8/18.
//

import SwiftUI
import UIKit.UIImage

public struct EnlargedView: View 
{
    private let image: UIImage
    
    @State
    private var scale: CGFloat = 1.0
        
    @State
    private var lastScale: CGFloat = 1.0
    
    public var body: some View {
        
        GeometryReader {
            
            proxy in
            
            ScrollView([.vertical, .horizontal], showsIndicators: true) {
                
                ZStack(alignment: .center) {
                    
                    let imageSize: CGSize = self.image.size * self.scale
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: imageSize.width, height: imageSize.height, alignment: .center)
                    
                    Image(uiImage: self.image)
                        .scaleEffect(self.scale)
                        .gesture(self.zoomGesture())
                }
            }
        }
    }
    
    public init(image: UIImage)
    {
        self.image = image
    }
}

private extension EnlargedView
{
    func imageSize(with viewSize: CGSize) -> CGSize
    {
        let imageSize: CGSize = viewSize.aspectRatio(with: self.image.size)
        
        return imageSize
    }
    
    func zoomGesture() -> some Gesture
    {
        let onChange: (CGFloat) -> Void = {
            
            let delta: CGFloat = $0 / self.lastScale
            self.lastScale = $0
            
            let newScale: CGFloat = max(delta * self.scale, 1.0)
            
            self.scale = newScale
        }
        
        let onEnded: (CGFloat) -> Void = {
            
            _ in
            
            self.lastScale = 1.0
        }
        
        let gesture = MagnificationGesture()
            .onChanged(onChange)
            .onEnded(onEnded)
        
        return gesture
    }
}

struct EnlargedView_Previews: PreviewProvider 
{
    static var previews: some View {
        
        EnlargedView(image: UIImage(named: "GawrGura")!)
    }
}
