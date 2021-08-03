//
//  MenuOption.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/8/3.
//

import Foundation

public struct MenuOption: SideMenuOption
{
    public private(set) var id: String = UUID().uuidString
    
    public private(set) var imageName: String
    
    public private(set) var title: String
    
    public init(imageName: String, title: String)
    {
        self.imageName = imageName
        self.title = title
    }
}
