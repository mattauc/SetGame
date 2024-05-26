//
//  Diamond.swift
//  Set
//
//  Created by Matthew Auciello on 24/5/2024.
//

import SwiftUI
import CoreGraphics

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        //let center =  CGPoint(x: rect.midX, y: rect.midY)
        let start = CGPoint(x: rect.maxX, y: rect.midY)
        let top = CGPoint(x: rect.midX, y: rect.maxY)
        let bottom = CGPoint(x: rect.midX, y: rect.minY)
        let left = CGPoint(x: rect.minX, y: rect.midY)
        
        var p = Path()
        p.move(to: start)
        p.addLine(to: top)
        p.addLine(to: left)
        p.addLine(to: bottom)
        p.addLine(to: start)

        return p
    }
}
