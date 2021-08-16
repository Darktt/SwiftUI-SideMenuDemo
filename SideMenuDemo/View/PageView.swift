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
    
    public init(style: PageTabViewStyle = .init(), @ViewBuilder content: @escaping ContentBuilder)
    {
        self.style = style
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
        
        PageView(style: PageTabViewStyle(indexDisplayMode: .always)) {
            
            ForEach(0 ... 3) {
                
                let ordinal = Ordinal(wrappedValue: $0 + 1)
                
                Text("\(ordinal.value) page.")
            }
        }.background(Color.green)
        .ignoresSafeArea()
    }
}
