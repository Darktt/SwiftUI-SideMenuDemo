//
//  AboutView.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/8/9.
//

import SwiftUI

public struct AboutView: View 
{
    @ObservedObject
    private var aboutDevice: AboutDevice = AboutDevice()
    
    public var body: some View {
        
        ScrollView {
            
            LazyVStack {
                
                ForEach(0 ..< self.aboutDevice.count, id: \.self) {
                    
                    index in
                    
                    self.cell(with: index)
                        .foregroundColor(Color.sharkWhite)
                        .background(Color.clear)
                }
            }
        }.background(Color.sharkBlue)
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(edges: .bottom)
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
        
        if index == 2 {
            
            AboutCell(title: "Network", detail: self.aboutDevice.networkStatus.description)
        }
    }
}

struct AboutView_Previews: PreviewProvider 
{
    static var previews: some View {
        
        AboutView()
    }
}
