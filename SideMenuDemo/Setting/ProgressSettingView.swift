//
//  ProgressSettingView.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/8/6.
//

import SwiftUI

public struct ProgressSettingView: View
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
        }.navigationTitle("Progress")
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea()
    }
}

struct ProgressSettingView_Previews: PreviewProvider 
{
    static var previews: some View {
        
        NavigationView {
            
            ProgressSettingView()
        }
    }
}
