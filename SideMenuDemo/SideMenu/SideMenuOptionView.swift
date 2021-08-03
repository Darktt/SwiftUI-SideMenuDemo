//
//  SideMenuOptionView.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/7/30.
//

import SwiftUI

public struct SideMenuOptionView<Option>: View where Option: SideMenuOption
{
    private var option: Option
    
    public var body: some View {
        
        HStack {
            
            Image(systemName: self.option.imageName)
                .frame(width: 24.0, height: 24.0)
            
            Text(self.option.title)
                .font(.system(size: 15.0, weight: .semibold))
            
            Spacer()
        }
        .padding()
        .foregroundColor(Color.sharkText)
    }
    
    public init(option: Option)
    {
        self.option = option
    }
}

struct SideMenuOptionView_Previews: PreviewProvider
{
    struct PreviewOption: SideMenuOption
    {
        var id: String = UUID().uuidString
        
        var imageName: String = "person"
        
        var title: String = "Profile"
    }
    
    static var previews: some View {
        
        SideMenuOptionView(option: PreviewOption())
    }
}
