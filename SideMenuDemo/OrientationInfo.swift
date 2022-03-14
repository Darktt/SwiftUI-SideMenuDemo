//
//  OrientationInfo.swift
//
//  Created by Darktt on 22/1/21.
//

import SwiftUI

public
final class OrientationInfo: ObservableObject
{
    // MARK: - Properties -
    
    @Published
    public var orientation: Orientation
    
    private var observer: NSObjectProtocol?
    
    private let device: UIDevice = .current
    private let notificationCenter: NotificationCenter = .default
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public init()
    {
        // fairly arbitrary starting value for 'flat' orientations
        self.orientation = self.device.orientation.isLandscape ? .landscape : .portrait
        
        // unowned self because we unregister before self becomes invalid
        self.observer = self.notificationCenter.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: nil, using: self.handleOrientationChangeNotification(_:))
    }
    
    deinit
    {
        guard let observer = self.observer else {
            
            return
        }
        
        self.notificationCenter.removeObserver(observer)
    }
}

// MARK: - Private Methods -

private extension OrientationInfo
{
    func handleOrientationChangeNotification(_ sender: Notification)
    {
        guard let device = sender.object as? UIDevice else {
            
            return
        }
        
        self.orientation = device.orientation.isLandscape ? .landscape : .portrait
    }
}

// MARK: - OrientationInfo.Orientation -

public extension OrientationInfo
{
    enum Orientation
    {
        case portrait
        case landscape
    }
}
