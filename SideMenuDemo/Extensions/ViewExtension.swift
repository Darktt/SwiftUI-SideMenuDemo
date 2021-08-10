//
//  ViewExtension.swift
//
//  Created by Darktt on 21/8/4.
//

import SwiftUI

extension View
{
    @ViewBuilder
    func linearGradient(colors: Array<Color>, startPoint: UnitPoint, endPoint: UnitPoint, ignoreSafeArea: Bool = false) -> some View
    {
        let gradient = Gradient(colors: colors)
        let linearGradient = LinearGradient(gradient: gradient, startPoint: startPoint, endPoint: endPoint)
        
        if ignoreSafeArea {
            
            self.background(linearGradient.ignoresSafeArea())
        } else {
            
            self.background(linearGradient)
        }
    }
    
    @ViewBuilder
    func angularGradient(colors: Array<Color>, center: UnitPoint, ignoreSafeArea: Bool = false) -> some View
    {
        let gradient = Gradient(colors: colors)
        let angularGradient = AngularGradient(gradient: gradient, center: center)
        
        if ignoreSafeArea {
            
            self.background(angularGradient.ignoresSafeArea())
        } else {
            
            self.background(angularGradient)
        }
    }
    
    @ViewBuilder
    func radialGradient(colors: Array<Color>, center: UnitPoint, startRadius: CGFloat, endRadius: CGFloat, ignoreSafeArea: Bool = false) -> some View
    {
        let gradient = Gradient(colors: colors)
        let radialGradient = RadialGradient(gradient: gradient, center: center, startRadius: startRadius, endRadius: endRadius)
        
        if ignoreSafeArea {
            
            self.background(radialGradient.ignoresSafeArea())
        } else {
            
            self.background(radialGradient)
        }
    }
}
