//
//  StripedShader.swift
//  Set
//
//  Created by Matthew Auciello on 25/5/2024.
//

import SwiftUI

struct CardFactoryView<T>: View where T: Shape {
    let numberOfStrips: Int = 5
    let lineWidth: CGFloat = 0.5
    let borderLineWidth: CGFloat = 2
    let colour: Color
    let shading: String
    let shape: T
    
    var body: some View {
        shadingSelector
    }
    
    @ViewBuilder
    var shadingSelector: some View {
        if shading == "solid" {
            colour
            .mask(shape)
            .overlay(shape.stroke(colour, lineWidth: borderLineWidth))
        } else if shading == "striped" {
            colourStripes
            .mask(shape)
            .overlay(shape.stroke(colour, lineWidth: borderLineWidth))
        } else {
            shape.stroke(colour, lineWidth: borderLineWidth)
        }
    }
    
    private var colourStripes: some View {
        HStack(spacing: 0) {
            ForEach(0..<5) { number in
                Color.white
                colour.frame(width: lineWidth)
                if number == numberOfStrips - 1 {
                    Color.white
                }
            }
        }
    }
}
