//
//  PageView.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/8/16.
//

import SwiftUI

public struct PageView<Content>: View where Content: View
{
    // MARK: - Properties -
    
    public var body: some View {
        
        TabView(content: self.contentBuilder)
            .tabViewStyle(self.style)
    }
    
    private let style: PageTabViewStyle
    
    private let contentBuilder: ContentBuilder
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public init(displayMode: PageTabViewStyle.IndexDisplayMode = .automatic , @ViewBuilder content: @escaping ContentBuilder)
    {
        self.style = PageTabViewStyle(indexDisplayMode: displayMode)
        self.contentBuilder = content
    }
}

public extension PageView
{
    typealias ContentBuilder = () -> Content
}

struct PageView_Previews: PreviewProvider 
{
    static var previews: some View {
        
        PageView(displayMode: .always) {
            
            ForEach(0 ... 3) {
                
                Text("\($0) page.")
            }
        }.background(Color.green)
        .ignoresSafeArea()
    }
}
