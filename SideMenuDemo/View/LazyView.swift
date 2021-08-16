//
//  LazyView.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/8/12.
//

import SwiftUI

public struct LazyView<Content>: View where Content: View
{
    // MARK: - Properties -
    
    private var contentBuilder: () -> Content
    
    public var body: Content {
        
        self.contentBuilder()
    }
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public init(_ builder: @autoclosure @escaping () -> Content)
    {
        self.contentBuilder = builder
    }
    
    public init(@ViewBuilder _ builder: @escaping () -> Content)
    {
        self.contentBuilder = builder
    }
}

struct LazyView_Previews: PreviewProvider 
{
    static var previews: some View {
        
        LazyView(Text("Lazy"))
    }
}
