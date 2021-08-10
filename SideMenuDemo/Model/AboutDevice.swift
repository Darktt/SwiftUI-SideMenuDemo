//
//  AboutDevice.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/8/9.
//

import UIKit

public struct AboutDevice
{
    public let deviceModel: String = {
        
        let detailDeviceModel: String = UIDevice.detailDeviceModel()
        let deviceModel: String = NSLocalizedString(detailDeviceModel, comment: "")
        
        return deviceModel
    }()
    
    public let carriers: [String] = DTCarrierInfo().carrierNames
    
    public let count: Int = 2
}
