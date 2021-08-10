//
//  DTCarrierInfo.swift
//
//  Created by Eden on 2020/12/1.
//  Copyright © 2020 Darktt. All rights reserved.
//

import Foundation
import CoreTelephony.CTCarrier
import CoreTelephony.CTTelephonyNetworkInfo

public struct DTCarrierInfo
{
    // MARK: - Properties -
    
    private var carriers: [CTCarrier] {
        
        let networkInfo = CTTelephonyNetworkInfo()
        let carriers: [CTCarrier]? = networkInfo.serviceSubscriberCellularProviders?.values.map({ $0 })
        
        return carriers ?? []
    }
    
    /// Get carrier names from you dual SIM cards.
    public var carrierNames: [String] {
        
        self.carrierComponents(withKeyPath: \.carrierName)
    }
    
    /// Get carrier name, if have more one SIM card, will get two carrier names.
    public var carrierName: String {
        
        self.carrierString(withKeyPath: \.carrierName)
    }
    
    /// Get carrier's mobile country codes from you dual SIM cards.
    public var mobileCountryCodes: [String] {
        
        self.carrierComponents(withKeyPath: \.mobileCountryCode)
    }
    
    /// Get carrier's mobile country code, if have more one SIM card, will get two codes.
    public var mobileCountryCode: String {
        
        self.carrierString(withKeyPath: \.mobileCountryCode)
    }
    
    /// Get carrier's ISO country codes from you dual SIM cards.
    public var iSOCountryCodes: [String] {
        
        self.carrierComponents(withKeyPath: \.isoCountryCode)
    }
    
    /// Get carrier's ISO country code, if have more one SIM card, will get two codes.
    public var iSOCountryCode: String {
        
        self.carrierString(withKeyPath: \.isoCountryCode)
    }
    
    /// Get carrier's mobile network codes from you dual SIM cards.
    public var mobileNetworkCodes: [String] {
        
        self.carrierComponents(withKeyPath: \.mobileNetworkCode)
    }
    
    /// Get carrier's mobile network code, if have more one SIM card, will get two codes.
    public var mobileNetworkCode: String {
        
        self.carrierString(withKeyPath: \.mobileNetworkCode)
    }
    
    /// Get carrier's allows making VoIP calls on its network from you dual SIM cards.
    public var allowsVOIPs: [Bool] {
        
        self.carrierComponents(withKeyPath: \.allowsVOIP)
    }
    
    /// Get carrier's allows making VoIP calls on its network.
    public var allowsVOIP: Bool {
        
        let allowsVOIPs: [Bool] = self.allowsVOIPs
        let allowsVOIP: Bool = allowsVOIPs.reduce(into: false) {
            
            $0 = $0 || $1
        }
        
        return allowsVOIP
    }
}

// MARK: - Privare Methods -

private extension DTCarrierInfo
{
    func carrierComponents<Component>(withKeyPath keyPath: KeyPath<CTCarrier, Component>) -> [Component]
    {
        guard !self.carriers.isEmpty else {
            
            return []
        }
        
        let components: [Component] = self.carriers.map({ $0[keyPath: keyPath] })
        
        return components
    }
    
    func carrierComponents<Component>(withKeyPath keyPath: KeyPath<CTCarrier, Component?>) -> [Component]
    {
        guard !self.carriers.isEmpty else {
            
            return []
        }
        
        let components: [Component] = self.carriers.compactMap({ $0[keyPath: keyPath] })
        
        return components
    }
    
    func carrierString<Component>(withKeyPath keyPath: KeyPath<CTCarrier, Component?>) -> String where Component: StringProtocol
    {
        let components: [Component] = self.carrierComponents(withKeyPath: keyPath)
        
        guard !components.isEmpty else {
            
            return "Unknow"
        }
        
        let carrierString: String = components.joined(separator: ", ")
        
        return carrierString
    }
}
