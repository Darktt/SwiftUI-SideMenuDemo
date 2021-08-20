//
//  NavigationMenuItem.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/8/19.
//

import SwiftUI

public struct NavigationMenuItem<Title>: View where Title: StringProtocol
{
    // MARK: - Properties -
    
    public var body: some View {
        
        Text(self.title)
            .padding(.horizontal)
            .padding(.vertical, 4)
            .background(self.background)
            .foregroundColor(self.foregroundColor)
            .onTapGesture {
                
                guard !self.selected else {
                    
                    return
                }
                
                self.onSelectedHandler(self.title)
            }
    }
    
    private let title: Title
    
    @Binding
    private var selected: Bool
    
    private var onSelectedHandler: OnSelectedHandler
    
    @ViewBuilder
    private var background: some View {
        
        if self.selected {
            
            Capsule().foregroundColor(.purple)
        } else {
            
            Capsule().foregroundColor(Color(.systemGray3))
        }
    }
    
    private var foregroundColor: Color {
        
        if self.selected {
            
            return .white
        }
        
        return .black
    }
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public init(_ title: Title, selected: Binding<Bool>, onSelected: @escaping OnSelectedHandler)
    {
        self.title = title
        self._selected = selected
        self.onSelectedHandler = onSelected
    }
    
    @ViewBuilder
    func withMatchedGeometryEffect<ID>(id: ID, in namespace: Namespace.ID, enabled: Bool) -> some View where ID: Hashable
    {
        if enabled {
            
            self.matchedGeometryEffect(id: id, in: namespace)
        } else {
            
            self
        }
    }
}

public extension NavigationMenuItem
{
    typealias OnSelectedHandler = (Title) -> Void
}
