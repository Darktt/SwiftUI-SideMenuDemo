//
//  PagesView.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/8/16.
//

import SwiftUI

public struct PagesView: View 
{
    public var body: some View {
        
        PageView(displayMode: .always) {
            
            ForEach(0 ... 3) {
                
                pageIndex in
                
                ZStack(alignment: .top) {
                    
                    [Color.red, .blue, .orange, .accentColor][pageIndex].ignoresSafeArea()
                    
                    VStack(alignment: .center) {
                        
                        Text("\(pageIndex) page.")
                            .padding()
                        
                        Spacer()
                    }
                }
            }
        }.background(Color.green)
        .navigationTitle("Pages")
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea()
    }
}

struct PagesView_Previews: PreviewProvider 
{
    static var previews: some View {
        
        PagesView()
    }
}
