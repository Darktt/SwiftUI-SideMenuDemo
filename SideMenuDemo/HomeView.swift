//
//  HomeView.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/7/30.
//

import SwiftUI

public struct HomeView: View
{
    public var body: some View {
        
        ZStack {
            
            Color.sharkWhite
            
            Text("Hello, world!")
                .foregroundColor(.sharkText)
                .padding()
        }
        .ignoresSafeArea()
    }
}

private extension HomeView
{
    func toolbarContent() -> some ToolbarContent
    {
        ToolbarItem(placement: .navigationBarLeading) {
            
            Button(action: self.sideMenuAction, label: {
                
                Image(systemName: "list.bullet")
            })
            .foregroundColor(.red)
        }
    }
    
    func sideMenuAction()
    {
        
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
