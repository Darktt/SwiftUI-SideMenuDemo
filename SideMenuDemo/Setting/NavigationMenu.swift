//
//  NavigationMenu.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/8/19.
//

import SwiftUI

public struct NavigationMenu: View 
{
    private let menuItems: Array<String> = ["Objective-C", "Swift", "Python", "Java"]
    
    @State
    private var selectedItem: String = "Objective-C"
    
    @Namespace
    private var menuItemTransation: Namespace.ID
    
    public var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
        
            HStack {
                
                Spacer()
                
                ForEach(self.menuItems) {
                    
                    let selected = Binding.constant($0 == self.selectedItem)
                    
                    NavigationMenuItem($0, selected: selected) {
                        
                        self.selectedItem = $0
                    }.withMatchedGeometryEffect(id: "NavigationMenuItem", in: self.menuItemTransation, enabled: selected.wrappedValue)
                    
                    Spacer()
                }
            }.animation(.easeInOut, value: self.selectedItem)
        }
    }
}

struct NavigationMenu_Previews: PreviewProvider 
{
    static var previews: some View {
        
        NavigationMenu()
    }
}
