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

public extension MenuOption
{
    static let profile: MenuOption = MenuOption(imageName: "person", title: "Profile")
    
    static let setting: MenuOption = MenuOption(imageName: "gear", title: "Setting")
    
    static let all: Array<MenuOption> = [.profile, .setting]
}

extension MenuOption: Equatable
{
    public static func == (lhs: MenuOption, rhs: MenuOption) -> Bool
    {
        var result: Bool = (lhs.imageName == rhs.imageName)
        result = result && (lhs.title == rhs.title)
        
        return result
    }
}
