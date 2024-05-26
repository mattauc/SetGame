//
//  SetViewModel.swift
//  Set
//
//  Created by Matthew Auciello on 24/5/2024.
//

import SwiftUI
import CoreGraphics

class SetViewModel: ObservableObject {
    
    @Published private var SetModel = createSetGame()
    
    private static let gameColours: [Color] = [.red, .purple, .green]
    private static let gameShapes: [String] = ["diamond", "rectangle", "ellipse"]
    private static let gameShading: [String] = ["solid", "striped", "open"]
    private static let gameSize: Int = 81
    
    private static func createSetGame() -> SetGame<Color> {
        return SetGame(shapes: gameShapes, colours: gameColours, shades: gameShading, gameSize: gameSize)
    }
    
    var cards: Array<SetGame<Color>.Card> {
        return SetModel.cards
    }
    
    func selectCard(_ card: SetGame<Color>.Card) {
        print(card)
        if !card.isSelected {
            SetModel.selectCard(card)
        } else {
            SetModel.deselectCard(card)
        }
    }
    
    func drawMore() {
        SetModel.buildCards(numberToDraw: 3)
    }
}

