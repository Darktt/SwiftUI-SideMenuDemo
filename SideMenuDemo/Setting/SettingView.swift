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
        
        LazyVStack(alignment: .leading) {
            
            ForEach(self.settings) {
                
                item in
                
                HStack(spacing: 10.0) {
                    
                    NavigationLink(destination: self.destinationView(with: item)) {
                        
                        Text(item.rawValue)
                            .font(.system(size: 20.0, weight: .semibold))
                            .foregroundColor(.sharkWhite)
                            .padding(.leading, 10.0)
                    }
                    
                    Spacer()
                }.frame(height: 50.0)
            }
        }.padding(.top, 0.3)
    }
}

private extension SettingView
{
    func destinationView(with item: SettingItem) -> AnyView
    {
        var view = AnyView(Text("a"))
        
        if item == .progress {
            
            view = AnyView(ProgressSettingView())
        }
        
        if item == .a {
            
            view = AnyView(AaaaaaView())
        }
        
        if item == .about {
            
            view = AnyView(AboutView())
        }
        
        return view
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
    
    case a = "a"
    
    case about = "About"
}

extension SettingItem
{
    static let all: Array<SettingItem> = [.progress, .a, .about]
}

extension SettingItem: Identifiable
{
    var id: String {
        
        self.rawValue
    }
}
