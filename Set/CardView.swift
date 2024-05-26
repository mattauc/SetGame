//
//  CardView.swift
//  Set
//
//  Created by Matthew Auciello on 24/5/2024.
//

import SwiftUI

struct CardView: View {
    typealias Card = SetGame<Color>.Card
    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
        
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            base.foregroundColor(.white)
            base.strokeBorder(lineWidth: 3)
            VStack() {
                CardContent
            }
            .padding()
        }
        .frame(minWidth: 70, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
    }
    
    
    var CardContent: some View {
        ForEach(0..<card.shapeCount, id: \.self) { num in
            selectedShapeView()
                .aspectRatio(2/3, contentMode: .fit)
                .minimumScaleFactor(0.01)
        }
    }
    
    @ViewBuilder
    func selectedShapeView() -> some View {
        switch card.shape {
            case "diamond":
                CardFactoryView<Diamond>(colour: card.colour, shading: card.shading, shape: Diamond())
            case "rectangle":
                CardFactoryView<Rectangle>(colour: card.colour, shading: card.shading, shape: Rectangle())
            default:
                CardFactoryView<Ellipse>(colour: card.colour, shading: card.shading, shape: Ellipse())
        }
    }
}

struct CardView_Previews: PreviewProvider {
    typealias Card = CardView.Card
    static var previews: some View {
        HStack {
            CardView(Card(shape: "ellipse", shapeCount: 2, colour: Color.green, shading: "striped", id: "c"))
            CardView(Card(shape: "rectangle", shapeCount: 3, colour: Color.blue, shading: "solid", id: "b"))
            CardView(Card(shape: "diamond", shapeCount: 1, colour: Color.red, shading: "striped", id: "h"))
            
        }
    }
}
