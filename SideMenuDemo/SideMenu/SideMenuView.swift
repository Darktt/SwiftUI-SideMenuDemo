//
//  SideMenuView.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/7/30.
//

import SwiftUI

public struct SideMenuView<Option>: View where Option: SideMenuOption
{
    // MARK: - Properties -
    
    @Binding
    private var isShowing: Bool
    
    private var options: Array<Option>
    
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
                
                ForEach(self.options) {
                    
                    option in
                    
                    SideMenuOptionView(option: option)
                }
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public init(options: Array<Option>, isShowing: Binding<Bool>)
    {
        self.options = options
        self._isShowing = isShowing
    }
}

struct SideMenuView_Previews: PreviewProvider
{
    struct PreviewOption: SideMenuOption
    {
        var id: String = UUID().uuidString
        
        var imageName: String = "person"
        
        var title: String = "Profile"
    }
    
    @State
    static var isShowing: Bool = false
    
    @State
    static var options: Array<PreviewOption> = [PreviewOption()]
    
    static var previews: some View {
        
        SideMenuView(options: self.options, isShowing: self.$isShowing)
            .preferredColorScheme(.light)
        
        SideMenuView(options: self.options, isShowing: self.$isShowing)
            .preferredColorScheme(.dark)
    }
}
