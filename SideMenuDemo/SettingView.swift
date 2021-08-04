//
//  SettingView.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/8/4.
//

import SwiftUI

public struct SettingView: View 
{
    public var body: some View {
        
        ZStack {
            
            Color.gray
                .opacity(8.0)
                .ignoresSafeArea()
            
            Text("Hello, World!")
        }
    }
}

struct SettingView_Previews: PreviewProvider 
{
    static var previews: some View {
        
        SettingView()
    }
}
