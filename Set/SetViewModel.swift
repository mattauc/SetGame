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
    
    private static let gameColours: [CustomColour] = [CustomColour.red, CustomColour.purple, CustomColour.green]
    private static let gameShapes: [String] = ["diamond", "rectangle", "ellipse"]
    private static let gameShading: [String] = ["solid", "striped", "open"]
    private static let gameSize: Int = 81
    
    private static func createSetGame() -> SetGame<CustomColour> {
        return SetGame(shapes: gameShapes, colours: gameColours, shades: gameShading, gameSize: gameSize)
    }
    
    
    var cards: Array<SetGame<CustomColour>.Card> {
        return SetModel.cards
    }
    
    func selectCard(_ card: SetGame<CustomColour>.Card) {
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
    
    func restartGame() {
        SetModel = SetViewModel.createSetGame()
    }
    
    func displayDrawButton() -> Bool {
        if SetModel.listOfCombinations.count == 0 {
            return false
        }
        return true
    }
}

enum CustomColour: String, Equatable {
    case red
    case green
    case purple
    
    var getColour: Color {
        switch self {
        case .red: return Color.red
        case .green: return Color.green
        case .purple: return Color.purple
        }
    }
    
    static func == (lhs: CustomColour, rhs: CustomColour) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
