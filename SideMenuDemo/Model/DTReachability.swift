//
//  DTReachability.swift
//
//  Created by Darktt on 16/11/24.
//  Copyright © 2016 Darktt. All rights reserved.
//

import Foundation
import SystemConfiguration

private func PrintReachabilityFlags(_ flags: SCNetworkReachabilityFlags, comment: String = #function)
{
    if _isDebugAssertConfiguration() {
        
        var log: String = "Reachability Flag Status: "
        log += flags.contains(.isWWAN) ? "W" : "-"
        log += flags.contains(.reachable) ? "R" : "-"
        log += " " //<- just a space.
        log += flags.contains(.transientConnection) ? "t" : "-"
        log += flags.contains(.connectionRequired) ? "c" : "-"
        log += flags.contains(.connectionOnTraffic) ? "C" : "-"
        log += flags.contains(.interventionRequired) ? "i" : "-"
        log += flags.contains(.connectionOnDemand) ? "D" : "-"
        log += flags.contains(.isLocalAddress) ? "l" : "-"
        log += flags.contains(.isDirect) ? "d" : "-"
        log += " " + comment
        
        print(log)
    }
}

private func htons(_ value: CUnsignedShort) -> CUnsignedShort
{
    return value.bigEndian
}

public final class DTReachability
{
    // MARK: - Properties -
    
    public var currentReachabilityStatus: DTReachability.NetworkStatus {
        
        let flags: SCNetworkReachabilityFlags = self.flags
        PrintReachabilityFlags(flags)
        
        if !flags.contains(.reachable) {
            
            // The target host is not reachable.
            return .notReachable
        }
        
        var status: NetworkStatus = .notReachable
        
        if !flags.contains(.connectionRequired) {
            
            /*
             If the target host is reachable and no connection is required then we'll assume (for now) that you're on Wi-Fi...
             */
            
            status = .reachableViaWiFi
        }
        
        if flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic) {
            
            /*
             ... and the connection is on-demand (or on-traffic) if the calling application is using the CFSocketStream or higher APIs...
             */
            
            if !flags.contains(.connectionRequired) {
                
                /*
                 ... and no [user] intervention is needed...
                 */
                status = .reachableViaWiFi
            }
        }
        
        if flags.contains(.isWWAN) {
            
            /*
             ... but WWAN connections are OK if the calling application is using the CFNetwork APIs.
             */
            status = .reachableViaWWAN
        }
        
        return status
    }
    
    public var isReachable: Bool {
        
        var result: Bool = false
        
        switch self.currentReachabilityStatus {
            
        case .notReachable:
            result = false
            
        case .reachableViaWiFi, .reachableViaWWAN:
            result = true
        }
        
        return result
    }
    
    public var connectionRequired: Bool {
        
        let flags: SCNetworkReachabilityFlags = self.flags
        
        return flags.contains(.connectionRequired)
    }
    
    private var reachability: SCNetworkReachability
    private var notifying: Bool = false
    
    private var flags: SCNetworkReachabilityFlags {
        
        var flags = SCNetworkReachabilityFlags(rawValue: 0)
        
        let gotFlags: Bool = withUnsafeMutablePointer(to: &flags, {
            
            SCNetworkReachabilityGetFlags(reachability, UnsafeMutablePointer($0))
        })
        
        guard gotFlags else {
            
            return []
        }
        
        return flags
    }
    
    // MARK: - Methods -
    // MARK: Static Methods
    
    public static func reachabilityForInternetConnection() -> DTReachability?
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        return DTReachability(hostAddress: zeroAddress)
    }
    
    // MARK: Initial Methods
    
    public init?(hostName: String)
    {
        guard let reachability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, hostName) else {
            
            return nil
        }
        
        self.reachability = reachability
    }
    
    public init?(hostAddress: sockaddr_in)
    {
        var address = hostAddress
        
        let _reachability: SCNetworkReachability? = withUnsafePointer(to: &address) {
            
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
            
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }
        
        guard let reachability = _reachability else {
            
            return nil
        }
        
        self.reachability = reachability
    }
    
    public convenience init?(ipAddress: String, port: UInt16 = 80)
    {
        var address = sockaddr_in()
        address.sin_len = UInt8(MemoryLayout.size(ofValue: address))
        address.sin_family = sa_family_t(AF_INET);
        address.sin_port = htons(port)
        
        inet_pton(AF_INET, ipAddress, &address.sin_addr)
        
        self.init(hostAddress: address)
    }
    
    deinit
    {
        self.stopNotifier()
    }
    
    // MARK: Public Methods
    
    @discardableResult
    public func startNotifier() -> Bool
    {
        guard !self.notifying else {
            return false
        }
        
        var context = SCNetworkReachabilityContext()
        context.info = Unmanaged.passUnretained(self).toOpaque()
        
        let callBack: SCNetworkReachabilityCallBack = {
            
            (_, flags, info) in
            
            guard let info: UnsafeMutableRawPointer = info else {
                
                return
            }
            
            let infoObject = Unmanaged<DTReachability>.fromOpaque(info).takeUnretainedValue()
            
            let notificationCenter = NotificationCenter.default
            notificationCenter.post(name: DTReachability.reachabilityChangedNotification, object: infoObject)
        }
        
        let success: Bool = SCNetworkReachabilitySetCallback(self.reachability, callBack, &context)
        
        if success {
            
            let scheduled: Bool = SCNetworkReachabilityScheduleWithRunLoop(self.reachability, CFRunLoopGetCurrent(), CFRunLoopMode.defaultMode.rawValue)
            
            if scheduled {
                
                self.notifying = true
            }
        }
        
        return self.notifying
    }
    
    public func stopNotifier()
    {
        guard self.notifying else {
            
            return
        }
        
        SCNetworkReachabilityUnscheduleFromRunLoop(self.reachability, CFRunLoopGetCurrent(), CFRunLoopMode.defaultMode.rawValue)
        
        notifying = false
    }
}

// MARK: - Notification Name and Enumerate -

public extension DTReachability
{
    static let reachabilityChangedNotification: Notification.Name = Notification.Name(rawValue: "ReachabilityChangedNotification")
    
    enum NetworkStatus
    {
        case notReachable
        
        case reachableViaWiFi
        
        case reachableViaWWAN
    }
}

extension DTReachability.NetworkStatus : CustomStringConvertible
{
    public var description: String {
        
        let description: String!
        
        switch self {
        case .notReachable:
            description = "Not reachable"
            
        case .reachableViaWiFi:
            description = "Reachable via Wi-Fi"
            
        case .reachableViaWWAN:
            description = "Reachable via WWAN"
        }
        
        return description
    }
}
