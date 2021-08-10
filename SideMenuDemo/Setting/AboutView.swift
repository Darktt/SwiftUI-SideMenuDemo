//
//  AboutView.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/8/9.
//

import SwiftUI

public struct AboutView: View 
{
    private var aboutDevice: AboutDevice = AboutDevice()
    
    public var body: some View {
        
        ScrollView {
            
            LazyVStack {
                
                ForEach(0 ..< self.aboutDevice.count) {
                    
                    index in
                    
                    self.cell(with: index)
                        .foregroundColor(Color.sharkWhite)
                        .background(Color.clear)
                }
            }
        }.background(Color.sharkBlue)
    }
}

private extension AboutView
{
    @ViewBuilder
    func cell(with index: Int) -> some View
    {
        if index == 0 {
            
            AboutCell(title: "Device", detail: self.aboutDevice.deviceModel)
        }
        
        if index == 1 {
            
            AboutCell(title: "Carrier", details: self.aboutDevice.carriers)
        }
    }
}

struct AboutView_Previews: PreviewProvider 
{
    static var previews: some View {
        
        AboutView()
    }
}
