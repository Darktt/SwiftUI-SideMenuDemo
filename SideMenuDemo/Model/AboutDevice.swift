//
//  AboutDevice.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/8/9.
//

import UIKit
import Combine

public class AboutDevice: ObservableObject
{
    public let deviceModel: String = {
        
        let detailDeviceModel: String = UIDevice.detailDeviceModel()
        let deviceModel: String = NSLocalizedString(detailDeviceModel, tableName: "DeviceName", comment: "")
        
        return deviceModel
    }()
    
    public let carriers: [String] = DTCarrierInfo().carrierNames
    
    @Published
    public private(set) var networkStatus: DTReachability.NetworkStatus
    
    public let count: Int = 3
    
    private let reachability: DTReachability? = DTReachability.reachabilityForInternetConnection()
    
    private var reachabilitySubscription: AnyCancellable? = nil
    
    public init() {
        
        self.networkStatus = .notReachable
        self.subscribe()
    }
    
    deinit
    {
        self.unsubscribe()
    }
}

private extension AboutDevice
{
    private func subscribe()
    {
        let subscription: AnyCancellable = DTReachability.status.sink {
            
            [weak self] in
            
            self?.networkStatus = $0
        }
        
        self.reachability?.startNotifier()
        self.reachabilitySubscription = subscription
    }
    
    private func unsubscribe()
    {
        self.reachability?.stopNotifier()
        self.reachabilitySubscription?.cancel()
    }
}
