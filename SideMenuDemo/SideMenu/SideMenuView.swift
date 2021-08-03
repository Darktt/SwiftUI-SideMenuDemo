//
//  SideMenuView.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/7/30.
//

import SwiftUI

public struct SideMenuView: View
{
    // MARK: - Properties -
    
    @Binding
    private var isShowing: Bool
    
    private var gradientColors: Array<Color> {
        
        [Color.sharkWhite, Color.sharkBlue]
    }
    
    public var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: self.gradientColors), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                
                SideMenuHeaderView(isShowing: self._isShowing)
                    .frame(height: 240.0)
                
                ForEach(0 ..< 6) { _ in
                    
                    SideMenuOptionView()
                }
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public init(isShowing: Binding<Bool>)
    {
        self._isShowing = isShowing
    }
}

struct SideMenuView_Previews: PreviewProvider
{
    @State
    static var isShowing: Bool = false
    
    static var previews: some View {
        
        SideMenuView(isShowing: .constant(false))
            .preferredColorScheme(.light)
        
        SideMenuView(isShowing: .constant(false))
            .preferredColorScheme(.dark)
    }
}
