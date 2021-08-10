//
//  UIDeviceExtension.swift
//
//  Created by Eden on 2021/8/9.
//  
//

import UIKit.UIDevice

public extension UIDevice
{
    static func detailDeviceModel() -> String
    {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        
        let identifier: String = machineMirror.children.reduce("") {
            
            identifier, element in
            
            guard let value = element.value as? Int8, value != 0 else {
                
                return identifier
            }
            
            let type = String( UnicodeScalar( UInt8(value)))
            
            return identifier + type
        }
        
        return identifier
    }
}
