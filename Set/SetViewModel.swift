//
//  SetViewModel.swift
//  Set
//
//  Created by Matthew Auciello on 24/5/2024.
//

import SwiftUI
import CoreGraphics

class SetViewModel: ObservableObject {
    typealias Card = SetGame<CustomColour>.Card
    @Published private var SetModel = createSetGame()
    
    private static let gameColours: [CustomColour] = [CustomColour.red, CustomColour.purple, CustomColour.green]
    private static let gameShapes: [String] = ["diamond", "rectangle", "ellipse"]
    private static let gameShading: [String] = ["solid", "striped", "open"]
    private static let gameSize: Int = 81
    

    private static func createSetGame() -> SetGame<CustomColour> {
        return SetGame(shapes: gameShapes, colours: gameColours, shades: gameShading, gameSize: gameSize, numberToDraw: 12)
    }
    
    var deck: Array<SetGame<CustomColour>.Card> {
        return SetModel.deck
    }
    
    var dealtCards: Array<SetGame<CustomColour>.Card> {
        return SetModel.deck.filter { card in
            isDealt(card) && !card.isMatched}
    }
    
    var nonDealtCards: Array<SetGame<CustomColour>.Card> {
        return SetModel.deck.filter { !isDealt($0) }
    }
    
    var matched: Bool {
        return SetModel.match
    }
    
    var getMatchedList: Array<SetGame<CustomColour>.Card> {
        return SetModel.matchedList
    }
    
    private func isDealt(_ card: SetGame<CustomColour>.Card) -> Bool {
        return card.isDealt
    }
    
    func selectCard(_ card: SetGame<CustomColour>.Card) {
        if !card.isSelected {
            SetModel.selectCard(card)
        } else {
            SetModel.deselectCard(card)
        }
    }
    
    func discardMatching() {
        SetModel.replaceMatch()
    }
    
    func drawMore() -> Array<SetGame<CustomColour>.Card>{
        return SetModel.dealCards()
    }
    
    func restartGame() {
        SetModel = SetViewModel.createSetGame()
    }
    
    func displayDrawButton() -> Bool {
        if SetModel.deck.count == 0 {
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
