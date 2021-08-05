//
//  CircleProgressView.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/8/5.
//

import SwiftUI

public struct CircleProgressView: View 
{
    private var lineWidth: CGFloat = 5.0
    
    private var lineCap: CGLineCap = .round
    
    private var forgroundProgressColor: Color = Color(red: 0.0, green: 112.0 / 255.0, blue: 1.0)
    private var backgroundProgressColor: Color = Color(white: 1.0).opacity(0.1)
    
    private var strokStyle: StrokeStyle {
        
        StrokeStyle(lineWidth: self.lineWidth, lineCap: self.lineCap)
    }
    
    @Binding
    private var progress: CGFloat
    
    public var body: some View {
        
        ZStack {
            
            Circle().stroke(lineWidth: self.lineWidth)
                .foregroundColor(self.backgroundProgressColor)
            
            Circle().trim(from: 0.0, to: min(self.progress, 1.0))
                .stroke(style: self.strokStyle)
                .rotationEffect(Angle(degrees: 270.0))
                .foregroundColor(self.forgroundProgressColor)
        }
    }
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public init(progress: Binding<CGFloat>)
    {
        self._progress = progress
    }
    
    public func lineWidth(_ lineWidth: CGFloat) -> CircleProgressView
    {
        var progressView: CircleProgressView = self
        progressView.lineWidth = lineWidth
        
        return progressView
    }
    
    public func progressColor(forground: Color, background: Color = Color.white.opacity(0.1)) -> CircleProgressView
    {
        var progressView: CircleProgressView = self
        progressView.forgroundProgressColor = forground
        progressView.backgroundProgressColor = background
        
        return progressView
    }
}

struct CircleProgressView_Previews: PreviewProvider 
{
    @State
    static var progress: CGFloat = 0.23
    
    static var previews: some View {
        
        ZStack {
        
            Color.gray.ignoresSafeArea()
            
            VStack(spacing: 10.0) {
                
                CircleProgressView(progress: self.$progress)
                    .lineWidth(20.0)
                    .progressColor(forground: .blue)
                    .frame(width: 200.0, height: 200.0, alignment: .center)
                
                Slider(value: self.$progress, in: 0.0 ... 1.0)
                    .frame(width: 200.0)
            }
        }
    }
}
