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
                        
                        Spacer()
                    }
                }.frame(height: 50.0)
            }
        }.padding(.top, 0.3)
    }
}

private extension SettingView
{
    func destinationView(with item: SettingItem) -> LazyView<AnyView>
    {
        var view = LazyView(AnyView(Text("a")))
        
        if item == .progress {
            
            view = LazyView(AnyView(ProgressSettingView()))
        }
        
        if item == .a {
            
            view = LazyView(AnyView(AaaaaaView()))
        }
        
        if item == .about {
            
            view = LazyView(AnyView(AboutView()))
        }
        
        if item == .pages {
            
            view = LazyView(AnyView(PagesView()))
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
    
    case pages = "Pages"
}

extension SettingItem
{
    static let all: Array<SettingItem> = [.progress, .a, .about, .pages]
}

extension SettingItem: Identifiable
{
    var id: String {
        
        self.rawValue
    }
}
