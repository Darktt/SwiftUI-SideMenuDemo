//
//  CGSizeExtension.swift
//
//  Created by Eden on 2021/8/19.
//  
//

import CoreGraphics.CGGeometry

public extension CGSize
{
    static func * (lhs: CGSize, rhs: CGFloat) -> CGSize
    {
        var newSize: CGSize = lhs
        newSize.width *= rhs
        newSize.height *= rhs
        
        return newSize
    }
    
    func aspectRatio(with size: CGSize) -> CGSize
    {
        let longestLengthOfShape: CGFloat = max(size.width, size.height)
        let longestLengthOfBounds: CGFloat = max(self.width, self.height)
        
        let rate: CGFloat = longestLengthOfBounds / longestLengthOfShape
        var newSize: CGSize = size
        
        if longestLengthOfShape == size.width {
            
            let height: CGFloat = (size.height * rate).rounded(.toNearestOrAwayFromZero)
            
            newSize.height = height
        } else {
            
            let width: CGFloat = (size.width * rate).rounded(.toNearestOrAwayFromZero)
            
            newSize.width = width
        }
        
        return newSize
    }
}
