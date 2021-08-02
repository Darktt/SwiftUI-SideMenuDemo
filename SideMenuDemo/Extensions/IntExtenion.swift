//
//  IntExtenion.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/8/2.
//

import Foundation

extension Int: ReferenceConvertible
{
    public typealias ReferenceType = NSNumber
    typealias _ObjectiveCType = NSNumber
    
    public var debugDescription: String {
        
        "\(self)"
    }
    
    func _bridgeToObjectiveC() -> NSNumber {
        
        NSNumber(value: self)
    }
    
    static func _forceBridgeFromObjectiveC(_ source: NSNumber, result: inout Int?) {
        
        result = source.intValue
    }
    
    static func _conditionallyBridgeFromObjectiveC(_ source: NSNumber, result: inout Int?) -> Bool {
        
        self._forceBridgeFromObjectiveC(source, result: &result)
        
        return true
    }
    
    static func _unconditionallyBridgeFromObjectiveC(_ source: NSNumber?) -> Int {
        
        guard let value: Int = source?.intValue else {
            
            return 0
        }
        
        return value
        
    }
}
