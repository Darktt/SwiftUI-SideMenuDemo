//
//  SettingView.swift
//
//  Created by Darktt on 21/8/4.
//

import SwiftUI

public struct SettingView: View 
{
    private var settings: Array<SettingItem> = SettingItem.all
    
    public var body: some View {
        
        ZStack(alignment: .top) {
            
            Color.sharkBlue.ignoresSafeArea()
            
            LazyVStack(alignment: .leading) {
                
                ForEach(self.settings) {
                    
                    item in
                    
                    HStack(spacing: 10.0) {
                        
                        Button(item.rawValue) {
                            
                            self.selectSetting(with: item)
                        }.font(.system(size: 20.0, weight: .semibold))
                        .foregroundColor(.sharkWhite)
                        .padding(.leading, 10.0)
                        
                        Spacer()
                    }.frame(height: 50.0)
                }
            }.padding(.top, 0.3)
        }
    }
}

private extension SettingView
{
    func selectSetting(with item: SettingItem)
    {
        
    }
}

struct SettingView_Previews: PreviewProvider 
{
    static var previews: some View {
        
        SettingView()
    }
}

// MARK: - Setting Item -

private enum SettingItem: String
{
    case progress = "Progress"
}

extension SettingItem
{
    static let all: Array<SettingItem> = [.progress]
}

extension SettingItem: Identifiable
{
    var id: String {
        
        self.rawValue
    }
}
