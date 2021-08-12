//
//  DTReachability+Combine.swift
//
//  Created by Darktt on 21/8/11.
//  Copyright © 2021 Darktt. All rights reserved.
//

import Foundation
import Combine

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension DTReachability
{
    typealias Publisher<Output> = AnyPublisher<Output, Never>
    
    static var reachabilityChanged: Publisher<DTReachability> {
        
        let notificationName: Notification.Name = DTReachability.reachabilityChangedNotification
        let publisher: Publisher = NotificationCenter.default
                                                    .publisher(for: notificationName)
                                                    .compactMap({ $0.object as? DTReachability })
                                                    .eraseToAnyPublisher()
        
        return publisher
    }
    
    static var status: Publisher<NetworkStatus> {
        
        let publisher: Publisher = self.reachabilityChanged
                                        .map({ $0.currentReachabilityStatus })
                                        .eraseToAnyPublisher()
        
        return publisher
    }
    
    static var isReachable: Publisher<Bool> {
        
        let publisher: Publisher = self.reachabilityChanged
                                        .map({ $0.currentReachabilityStatus != .notReachable })
                                        .eraseToAnyPublisher()
        
        return publisher
    }
    
    static var isConnected: Publisher<Void> {
        
        let publisher: Publisher = self.isReachable
            .filter({ $0 })
            .map({ _ in })
            .eraseToAnyPublisher()
        
        return publisher
    }
    
    static var isDisconnected: Publisher<Void> {
        
        let publisher: Publisher = self.isReachable
            .filter({ !$0 })
            .map({ _ in })
            .eraseToAnyPublisher()
        
        return publisher
    }
}
