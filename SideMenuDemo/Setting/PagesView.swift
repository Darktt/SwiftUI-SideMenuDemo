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
        
        PageView(style: PageTabViewStyle(indexDisplayMode: .always)) {
            
            ForEach(0 ... 3) {
                
                pageIndex in
                
                VStack(alignment: .center) {
                    
                    let ordinal = Ordinal(wrappedValue: pageIndex + 1)
                    
                    Text("\(ordinal.value) page.")
                        .padding()
                    
                    Spacer()
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
