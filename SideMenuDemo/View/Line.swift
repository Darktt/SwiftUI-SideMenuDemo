//
//  Line.swift
//
//  Created by Darktt on 21/8/9.
//

import SwiftUI

public struct Line: View 
{
    // MARK: - Properties -
    
    private let style: LineStyle
    
    private var lineWidth: CGFloat = 1.0
    
    private var color: Color = Color.primary
    
    private var strokeStyle: StrokeStyle {
        
        var style = StrokeStyle(lineWidth: self.lineWidth, lineCap: .butt, lineJoin: .round)
        
        if self.style == .patternDot {
            
            style.dash = [self.lineWidth]
        }
        
        if self.style == .patternDash {
            
            style.dash = [self.lineWidth * 2.0, self.lineWidth]
        }
        
        if self.style == .patternDashDotDot {
            
            style.dash = [self.lineWidth * 2.0, self.lineWidth, self.lineWidth, self.lineWidth, self.lineWidth, self.lineWidth]
        }
        
        return style
    }
    
    public var body: some View {
        
        GeometryReader {
            
            proxy in
            
            Path {
                
                $0.move(to: .zero)
                $0.addLine(to: CGPoint(x: proxy.size.width, y: 0.0))
                
                if self.style == .double {
                    
                    let y: CGFloat = self.lineWidth + 5.0
                    var point = CGPoint(x: 0.0, y: y)
                    
                    $0.move(to: point)
                    
                    point.x = proxy.size.width
                    
                    $0.addLine(to: point)
                }
                
            }.stroke(self.color, style: self.strokeStyle)
        }
    }
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public init(style: LineStyle)
    {
        self.style = style
    }
    
    public func lineWidth(_ lineWidth: CGFloat = 1.0, color: Color = .primary) -> Line
    {
        var line: Line = self
        line.lineWidth = lineWidth
        line.color = color
        
        return line
    }
}

// MARK: - LineStyle -

public enum LineStyle
{
    case single
    
    case double
    
    case patternDot
    
    case patternDash
    
    case patternDashDotDot
}

fileprivate extension LineStyle
{
    var isLine: Bool {
        
        let isLine: Bool = (self == .single) || (self == .double)
        
        return isLine
    }
}

// MARK: - Private Extension -

fileprivate extension CGPoint
{
    static let xInfinity: CGPoint = CGPoint.xInfinity(y: 0.0)
    
    static func xInfinity(y: CGFloat) -> CGPoint
    {
        CGPoint(x: CGFloat.infinity, y: y)
    }
}

// MARK: - Preiview -

struct Line_Previews: PreviewProvider 
{
    static var previews: some View {
        
        Line(style: .patternDashDotDot)
            .lineWidth(5.0, color: .blue)
    }
}
