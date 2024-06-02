//
//  CardView.swift
//  Set
//
//  Created by Matthew Auciello on 24/5/2024.
//

import SwiftUI

struct CardView: View {
    typealias Card = SetGame<CustomColour>.Card
    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
        
    var body: some View {
        TimelineView(.animation) { timeline in
            CardContent
                .cardify(card: card)
                .transition(.scale)
        }
    }
    
    var CardContent: some View {
        VStack {
            ForEach(0..<card.shapeCount, id: \.self) { num in
                selectedShapeView()
                    .aspectRatio(2/3, contentMode: .fit)
                    .minimumScaleFactor(0.01)
            }
        }
        .padding()
    }
    
    @ViewBuilder
    func selectedShapeView() -> some View {
        switch card.shape {
            case "diamond":
            CardFactoryView<Diamond>(colour: card.colour.getColour, shading: card.shading, shape: Diamond())
            case "rectangle":
                CardFactoryView<Rectangle>(colour: card.colour.getColour, shading: card.shading, shape: Rectangle())
            default:
                CardFactoryView<Ellipse>(colour: card.colour.getColour, shading: card.shading, shape: Ellipse())
        }
    }
}
