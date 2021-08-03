//
//  SideMenuOption.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/8/3.
//

import Foundation

public protocol SideMenuOption: Identifiable
{
    var imageName: String { get }
    
    var title: String { get }
}
