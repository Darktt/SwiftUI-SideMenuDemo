//
//  AaaaaaView.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/8/9.
//

import SwiftUI

public struct AaaaaaView: View 
{
    public var body: some View {
        
        ZStack {
            
            Color.sharkBlue
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                
                HStack(alignment: .center) {
                    
                    Text("a")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.sharkWhite)
                }
            }.navigationTitle("a")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AaaaaaView_Previews: PreviewProvider 
{
    static var previews: some View {
        
        NavigationView {
            
            AaaaaaView()
        }
    }
}
