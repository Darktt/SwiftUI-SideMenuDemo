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
        var view = LazyView(Text("a").anyView)
        
        if item == .progress {
            
            view = LazyView(ProgressSettingView().anyView)
        }
        
        if item == .a {
            
            view = LazyView(AaaaaaView().anyView)
        }
        
        if item == .about {
            
            view = LazyView(AboutView().anyView)
        }
        
        if item == .pages {
            
            view = LazyView(PagesView().anyView)
        }
        
        if item == .enlargeImage {
            
            let image = UIImage(named: "GawrGura")!
            
            view = LazyView(EnlagedView(image: image).anyView)
        }
        
        if item == .navigationMenu {
            
            view = LazyView(NavigationMenu().anyView)
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
    
    case enlargeImage = "Enlarge Image"
    
    case navigationMenu = "Navigation Menu"
}

extension SettingItem
{
    static let all: Array<SettingItem> = [.progress, .a, .about, .pages, .enlargeImage, .navigationMenu]
}

extension SettingItem: Identifiable
{
    var id: String {
        
        self.rawValue
    }
}
