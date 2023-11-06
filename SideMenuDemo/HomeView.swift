//
//  HomeView.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/7/30.
//

import SwiftUI

public struct HomeView: View
{
    @EnvironmentObject var orientationInfo: OrientationInfo
    
    var imageAlignment: Alignment {
        
        if self.orientationInfo.orientation == .landscape {
            
            return .top
        }
        
        return .center
    }
    
    public var body: some View {
        
        ZStack {
            
            GeometryReader {
                
                Image(.gawrGura)
                    .frame(width: $0.size.width, height: $0.size.height, alignment: self.imageAlignment)
                    .clipped(antialiased: true)
            }
            .allowsHitTesting(false)
            .ignoresSafeArea()
            
            Text("Hello, world!")
                .foregroundColor(.sharkText)
                .padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider
{
    static var previews: some View {
        
        NavigationView {
            
            HomeView()
        }
    }
}
