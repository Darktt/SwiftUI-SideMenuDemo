//
//  Ordinal.swift
//  DTTest
//
//  Created by Eden on 2021/8/16.
//  Copyright © 2021 Darktt. All rights reserved.
//

import Foundation

@propertyWrapper
public struct Ordinal<D> where D: SignedNumeric
{
    // MARK: - Properties -
    
    public private(set) var value: String = ""
    
    public private(set) var wrappedValue: D {
        
        set {
            
            let number = NSNumber(newValue)
            
            if let value: String = self.numberFormatter.string(from: number) {
                
                self.value = value
            }
            
            self._wrappedValue = newValue
        }
        
        get {
            
            return self._wrappedValue
        }
    }
    
    private var _wrappedValue: D = D.zero
    
    private lazy var numberFormatter: NumberFormatter = {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        
        return formatter
    }()
    
    public init(wrappedValue: D)
    {
        self.wrappedValue = wrappedValue
    }
}

// MARK: - Private NSNumber Extension -

private extension NSNumber
{
    convenience init<S>(_ value: S) where S: SignedNumeric
    {
        if let integer = value as? Int8 {
            
            self.init(value: integer)
            return
        }
        
        if let integer = value as? Int16 {
            
            self.init(value: integer)
            return
        }
        
        if let integer = value as? Int32 {
            
            self.init(value: integer)
            return
        }
        
        if let integer = value as? Int64 {
            
            self.init(value: integer)
            return
        }
        
        if let integer = value as? Int {
            
            self.init(value: integer)
            return
        }
        
        if let double = value as? Double {
            
            self.init(value: double)
            return
        }
        
        self.init(value: value as! Float)
    }
}
