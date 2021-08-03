//
//  ContentView.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/7/30.
//

import SwiftUI

public struct ContentView: View
{
    @State
    private var isShowing: Bool = false
    
    private var cornerRadius: CGFloat {
        
        self.isShowing ? 20.0 : 0.0
    }
    
    private var xOffset: CGFloat {
        
        self.isShowing ? 300.0 : 0.0
    }
    
    private var yOffset: CGFloat {
        
        self.isShowing ? 44.0 : 0.0
    }
    
    private var scaleEffect: CGFloat {
        
        self.isShowing ? 0.8 : 1.0
    }
    
    public var body: some View {
        
        NavigationView {
            
            ZStack {
                
                if self.isShowing {
                    
                    SideMenuView(isShowing: self.$isShowing)
                }
                
                HomeView()
                    .blur(radius: self.isShowing ? 5.0 : 0.0)
                    .cornerRadius(self.cornerRadius)
                    .offset(x: self.xOffset, y: self.yOffset)
                    .scaleEffect(self.scaleEffect)
                    .navigationTitle("Home")
                    .toolbar(content: self.toolbarContent)
                    .ignoresSafeArea()
            }
        }
    }
}

private extension ContentView
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
        withAnimation(.easeInOut(duration: 0.25)) {
            
            self.isShowing.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View {
        
        ContentView()
    }
}
