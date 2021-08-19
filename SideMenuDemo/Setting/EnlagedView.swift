//
//  EnlagedView.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/8/18.
//

import SwiftUI
import UIKit.UIImage

public struct EnlagedView: View 
{
    private var image: UIImage = UIImage(named: "GawrGura")!
    
    @State
    private var scale: CGFloat = 1.0
        
    @State
    private var lastScaleValue: CGFloat = 1.0
    
    public var body: some View {
        
        ScrollView([.vertical, .horizontal], showsIndicators: true) {
            
            ZStack {
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: self.image.size.width * self.scale, height: self.image.size.height * self.scale, alignment: .center)
                
                Image(uiImage: self.image)
                    .scaleEffect(self.scale)
                    .gesture(self.zoomGestrue())
            }
        }
    }
}

private extension EnlagedView
{
    func zoomGestrue() -> some Gesture
    {
        let onChange: (CGFloat) -> Void = {
            
            _ in
        }
        
        let onEnded: (CGFloat) -> Void = {
            
            _ in
            
            self.lastScaleValue = 1.0
        }
        
        let gesture = MagnificationGesture()
            .onChanged(onChange)
            .onEnded(onEnded)
        
        return gesture
    }
}

struct EnlagedView_Previews: PreviewProvider 
{
    static var previews: some View {
        
        EnlagedView()
    }
}
