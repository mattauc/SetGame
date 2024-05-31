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
        CardContent
            .cardify(card: card)
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

struct CardView_Previews: PreviewProvider {
    typealias Card = CardView.Card
    static var previews: some View {
        HStack {
            CardView(Card(shape: "ellipse", shapeCount: 2, colour: CustomColour.green, shading: "striped", id: "c"))
            CardView(Card(shape: "rectangle", shapeCount: 3, colour: CustomColour.purple, shading: "solid", id: "b"))
            CardView(Card(shape: "diamond", shapeCount: 1, colour: CustomColour.red, shading: "striped", id: "h"))
            
        }
    }
}
