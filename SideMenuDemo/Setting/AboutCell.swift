//
//  AboutCell.swift
//  SideMenuDemo
//
//  Created by Eden on 2021/8/9.
//

import SwiftUI

public struct AboutCell: View
{
    private var title: String
    
    private var details: Array<String>
    
    public var body: some View {
        
        VStack(alignment: .leading, spacing: 2.0) {
            
            HStack(alignment: .center) {
                
                Text(self.title)
                    .font(.title3)
                    .fontWeight(.heavy)
                    .padding(.leading)
                
                Spacer()
            }
            
            Line(style: .double)
                .lineWidth(1.0, color: .sharkWhite)
            
            ForEach(self.details) {
                
                detail in
                
                HStack(alignment: .center) {
                    
                    Spacer()
                    
                    Text(detail)
                        .padding(.trailing)
                }
            }
            
            if self.details.isEmpty {
                
                HStack {
                    
                    Spacer()
                    
                    Text("Place holder")
                        .foregroundColor(.clear)
                }
            }
        }
    }
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public init(title: String, detail: String...)
    {
        self.title = title
        self.details = detail
    }
    
    public init(title: String, details: Array<String>)
    {
        self.title = title
        self.details = details
    }
}

struct AboutCell_Previews: PreviewProvider
{
    static var previews: some View {
        
        ScrollView {
            
            AboutCell(title: "Title", details: ["detail 1", "detail 2"])
            
            AboutCell(title: "Empty detail", details: [])
        }
    }
}
