//
//  SideMenuHeaderView.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/7/30.
//

import SwiftUI

public struct SideMenuHeaderView: View
{
    // MARK: - Properties -
    
    @Binding
    private var isShowing: Bool
    
    public var body: some View {
        
        ZStack(alignment: .topTrailing) {
            
            self.closeButton()
            
            VStack(alignment: .leading) {
                
                Image("GawrGura")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 64.0, height: 64.0, alignment: .top)
                    .clipShape(Circle())
                    .clipped()
                    .padding(0.0)
                    .overlay(self.imageOverlay())
                
                Text("Gawr Gura")
                    .font(.system(size: 24.0, weight: .semibold))
                
                Text("@gawrgura")
                    .font(.system(size: 14.0))
                    .padding(.bottom, 24.0)
                
                HStack(spacing: 12.0) {
                    
                    HStack(spacing: 4.0) {
                        
                        Text("98").bold()
                        Text("Following")
                    }
                    
                    HStack(spacing: 4.0) {
                        
                        Text("1,094,016").bold()
                        Text("Followers")
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
        }
        .padding()
        .foregroundColor(Color.sharkText)
    }
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public init(isShowing: Binding<Bool>)
    {
        self._isShowing = isShowing
    }
}

private extension SideMenuHeaderView
{
    func closeButton() -> some View
    {
        Button(action: self.closeAction, label: {
            
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 22.0, height: 22.0)
                .foregroundColor(.sharkText)
        })
    }
    
    func imageOverlay() -> some View
    {
        Circle()
            .strokeBorder(Color.black)
            .padding(0.0)
    }
    
    func closeAction()
    {
        withAnimation(.spring()) {
            
            self.isShowing = false
        }
    }
}

struct SideMenuHeaderView_Previews: PreviewProvider
{
    @State
    static var isShowing: Bool = false
    
    static var previews: some View {
        
        SideMenuHeaderView(isShowing: self.$isShowing)
    }
}
