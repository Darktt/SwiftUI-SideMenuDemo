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
    private let serialQueue: DispatchQueue = DispatchQueue(label: "tw.com.darktt.personal.company", qos: .default, target: nil)
    
    private var notifying: Bool = false
    
    private var flags: SCNetworkReachabilityFlags = [] {
        
        willSet {
            
            self.postReachabilityChange()
        }
    }
    
    // MARK: - Methods -
    // MARK: Static Methods
    
    public static func reachabilityForInternetConnection() -> DTReachability?
    {
        var zeroAddress = sockaddr()
        zeroAddress.sa_len = UInt8(MemoryLayout<sockaddr>.size)
        zeroAddress.sa_family = sa_family_t(AF_INET)
        
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
    
    public init?(hostAddress: sockaddr)
    {
        var address: sockaddr = hostAddress
        
        guard let reachability = SCNetworkReachabilityCreateWithAddress(nil, &address) else {
            
            return nil
        }
        
        self.reachability = reachability
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
        
        let callBack: SCNetworkReachabilityCallBack = {
            
            (_, _, info) in
            
            guard let info: UnsafeMutableRawPointer = info else {
                
                return
            }
            
            DispatchQueue.main.async {
                
                let infoObject = Unmanaged<DTReachabilityWeakifier>.fromOpaque(info).takeUnretainedValue()
                
                let notificationCenter = NotificationCenter.default
                notificationCenter.post(name: DTReachability.reachabilityChangedNotification, object: infoObject.reachability)
            }
        }
        
        let weakifiedReachability = DTReachabilityWeakifier(reachability: self)
        let unsafeReachability: UnsafeMutableRawPointer = Unmanaged.passUnretained(weakifiedReachability).toOpaque()
        
        var context = SCNetworkReachabilityContext(version: 0, info: unsafeReachability,
                                                   retain: {
                                                    
                                                    let unmanagedReachability = Unmanaged<DTReachabilityWeakifier>.fromOpaque($0)
                                                    _ = unmanagedReachability.retain()
                                                    
                                                    return UnsafeRawPointer(unmanagedReachability.toOpaque())
                                                },
                                                   release: {
                                                    
                                                    let unmanagedReachability = Unmanaged<DTReachabilityWeakifier>.fromOpaque($0)
                                                    unmanagedReachability.release()
                                                },
                                                   copyDescription: {
                                                    
                                                    let unmanagedReachability = Unmanaged<DTReachabilityWeakifier>.fromOpaque($0)
                                                    let reachability: DTReachabilityWeakifier = unmanagedReachability.takeUnretainedValue()
                                                    
                                                    let description: String = reachability.reachability?.description ?? "nil"
                                                    
                                                    return Unmanaged.passRetained(description as CFString)
                                                })
        
        if !SCNetworkReachabilitySetCallback(self.reachability, callBack, &context) {
            
            return false
        }
        
        if !SCNetworkReachabilitySetDispatchQueue(self.reachability, self.serialQueue) {
            
            return false
        }
        
        self.notifying = true
        self.fetchReachabilityFlags()
        
        return self.notifying
    }
    
    public func stopNotifier()
    {
        guard self.notifying else {
            
            return
        }
        
        SCNetworkReachabilitySetCallback(self.reachability, nil, nil)
        SCNetworkReachabilitySetDispatchQueue(self.reachability, nil)
        
        notifying = false
    }
    
    func fetchReachabilityFlags()
    {
        self.serialQueue.sync {
            
            var flags = SCNetworkReachabilityFlags()
            
            if SCNetworkReachabilityGetFlags(self.reachability, &flags) {
                
                self.flags = flags
            }
        }
    }
    
    func postReachabilityChange()
    {
        DispatchQueue.main.async {
            
            [weak self] in
            
            guard let strongSelf = self else {
                
                return
            }
            
            let notificationCenter = NotificationCenter.default
            notificationCenter.post(name: DTReachability.reachabilityChangedNotification, object: strongSelf)
        }
    }
}

extension DTReachability: CustomStringConvertible
{
    public var description: String {
        
        self.currentReachabilityStatus.description
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

// MARK: - DTReachabilityWeakifier -

/**
 `DTReachabilityWeakifier` weakly wraps the `Reachability` class
 in order to break retain cycles when interacting with CoreFoundation.

 CoreFoundation callbacks expect a pair of retain/release whenever an
 opaque `info` parameter is provided. These callbacks exist to guard
 against memory management race conditions when invoking the callbacks.

 #### Race Condition

 If we passed `SCNetworkReachabilitySetCallback` a direct reference to our
 `Reachability` class without also providing corresponding retain/release
 callbacks, then a race condition can lead to crashes when:
 - `Reachability` is deallocated on thread X
 - A `SCNetworkReachability` callback(s) is already in flight on thread Y

 #### Retain Cycle

 If we pass `Reachability` to CoreFoundtion while also providing retain/
 release callbacks, we would create a retain cycle once CoreFoundation
 retains our `Reachability` class. This fixes the crashes and his how
 CoreFoundation expects the API to be used, but doesn't play nicely with
 Swift/ARC. This cycle would only be broken after manually calling
 `stopNotifier()` — `deinit` would never be called.

 #### ReachabilityWeakifier

 By providing both retain/release callbacks and wrapping `Reachability` in
 a weak wrapper, we:
 - interact correctly with CoreFoundation, thereby avoiding a crash.
 See "Memory Management Programming Guide for Core Foundation".
 - don't alter the public API of `Reachability.swift` in any way
 - still allow for automatic stopping of the notifier on `deinit`.
 */

private class DTReachabilityWeakifier
{
    fileprivate weak var reachability: DTReachability?
    
    fileprivate init(reachability: DTReachability)
    {
        self.reachability = reachability
    }
}
