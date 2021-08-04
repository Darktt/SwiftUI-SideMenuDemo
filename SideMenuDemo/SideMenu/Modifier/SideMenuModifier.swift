//
//  SideMenuModifier.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/8/4.
//

import SwiftUI

public struct SideMenuModifier: ViewModifier
{
    // MARK: - Properties -
    
    public var isShowing: Bool = false
    
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
    
    // MARK: - Methods -
    
    public func body(content: Content) -> some View
    {
        content.blur(radius: self.isShowing ? 5.0 : 0.0)
            .cornerRadius(self.cornerRadius)
            .offset(x: self.xOffset, y: self.yOffset)
            .scaleEffect(self.scaleEffect)
    }
}

public extension View
{
    func showingMenu(_ isShowing: Bool) -> some View
    {
        let modifier = SideMenuModifier(isShowing: isShowing)
        
        let result: ModifiedContent = self.modifier(modifier)
        
        return result
    }
}
