//
//  SettingView.swift
//
//  Created by Darktt on 21/8/4.
//

import SwiftUI

public struct SettingView: View 
{
    @State
    private var progress: CGFloat = 0.25
    
    public var body: some View {
        
        ZStack {
            
            Color.white
                .opacity(8.0)
                .ignoresSafeArea()
            
            VStack(spacing: 20.0) {
                
                CircleProgressView(progress: self.$progress)
                    .lineWidth(20.0)
                    .progressColor(forground: .sharkBlue, background: .sharkWhite)
                    .frame(width: 200.0, height: 200.0, alignment: .center)
                
                Slider(value: self.$progress, in: 0.0 ... 1.0)
                    .foregroundColor(.sharkBlue)
                    .frame(width: 200.0)
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider 
{
    static var previews: some View {
        
        SettingView()
    }
}
