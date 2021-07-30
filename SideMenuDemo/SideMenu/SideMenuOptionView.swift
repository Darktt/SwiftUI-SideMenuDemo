//
//  SideMenuOptionView.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/7/30.
//

import SwiftUI

public struct SideMenuOptionView: View
{
    public var body: some View {
        
        HStack {
            
            Image(systemName: "person")
                .frame(width: 24.0, height: 24.0)
            
            Text("Profile")
                .font(.system(size: 15.0, weight: .semibold))
            
            Spacer()
        }
        .padding()
        .foregroundColor(Color.sharkText)
    }
}

struct SideMenuOptionView_Previews: PreviewProvider
{
    static var previews: some View {
        
        SideMenuOptionView()
    }
}
