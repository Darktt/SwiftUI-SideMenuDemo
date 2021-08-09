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
    
    private var menuOptions: Array<MenuOption> = MenuOption.all
    
    @State
    fileprivate var currentMenuOption: MenuOption = MenuOption.profile
    
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
                    
                    SideMenuView(options: self.menuOptions, isShowing: self.$isShowing) {
                        
                        option in
                        
                        self.currentMenuOption = option
                        
                        withAnimation(.easeOut(duration: 0.25)) {
                            
                            self.isShowing.toggle()
                        }
                        
                    }.linearGradient(colors: [.sharkWhite, .sharkBlue], startPoint: .top, endPoint: .bottom, ignoreSafeArea: true)
                }
                
                self.mainView()
            }
        }
    }
}

private extension ContentView
{
    @ViewBuilder
    func mainView() -> some View
    {
        if self.currentMenuOption == .profile {
            
            HomeView()
                .navigationTitle("Home")
                .showingMenu(self.isShowing)
                .toolbar(content: self.toolbarContent)
                .ignoresSafeArea()
        }
        
        if self.currentMenuOption == .setting {
            
            ZStack {
                
                ScrollView(.vertical, showsIndicators: true) {
                    
                    SettingView()
                        .navigationTitle("Setting")
                }
                .padding()
                .background(Color.sharkBlue)
                .navigationTitle("Setting")
                .showingMenu(self.isShowing)
                .toolbar(content: self.toolbarContent)
                .ignoresSafeArea(edges: .bottom)
            }
        }
    }
    
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
    
    // For previews
    func previewMainView(with option: MenuOption) -> ContentView
    {
        var contentView: ContentView = self
        contentView._currentMenuOption = State(initialValue: option)
        
        return contentView
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View {
        
        ContentView()
//            .previewMainView(with: .profile)
//            .previewMainView(with: .setting)
    }
}
