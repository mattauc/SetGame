//
//  SetGame.swift
//  Set
//
//  Created by Matthew Auciello on 24/5/2024.
//

import Foundation

struct SetGame<Colour: Equatable> {
    private(set) var deck: Array<Card>
    private(set) var selectedCards: Array<Card>
    private(set) var cardIndex = 0
    private var setNumber = 3
    private(set) var numberToDraw: Int
    private(set) var match = false
    private(set) var matchedList: [Card] = []

    
    init(shapes: [String], colours: [Colour], shades: [String], gameSize: Int, numberToDraw: Int) {
        deck = []
        var count = 0
        for index in 1..<4 {
            for selectShape in shapes {
                for selectColour in colours {
                    for selectShade in shades {
                        count += 1
                        deck.append(Card(shape: selectShape, shapeCount: index, colour: selectColour, shading: selectShade, id: String(count)))
                    }
                }
            }
        }
        self.numberToDraw = numberToDraw
        selectedCards = []
        deck.shuffle()
    }
    
    var isMatch: Bool {
        return allSameOrAllDifferent(selectedCards[0].shape, selectedCards[1].shape, selectedCards[2].shape) &&
               allSameOrAllDifferent(selectedCards[0].shading, selectedCards[1].shading, selectedCards[2].shading) &&
               allSameOrAllDifferent(selectedCards[0].shapeCount, selectedCards[1].shapeCount, selectedCards[2].shapeCount) &&
               allSameOrAllDifferent(selectedCards[0].colour, selectedCards[1].colour, selectedCards[2].colour)
    }

    func allSameOrAllDifferent<T: Equatable>(_ a: T, _ b: T, _ c: T) -> Bool {
        return (a == b && b == c) || (a != b && b != c && a != c)
    }

    mutating func dealCards() -> Array<Card> {
        var dealingDeck: Array<Card> = []
        if (numberToDraw + cardIndex) <= deck.count {
            for index in cardIndex..<numberToDraw+cardIndex {
                deck[index].isFaceUp = true
                dealingDeck.append(deck[index])
                cardIndex += 1
            }
        }
        if numberToDraw > 3 {
            numberToDraw = 3
        }
        return dealingDeck
    }
    
    mutating func removeCards() {
        for selectedCard in selectedCards {
            if let index = deck.firstIndex(where: { $0.id == selectedCard.id }) {
                deck.remove(at: index)
            }
        }
    }
    
    mutating func selectCard(_ card: Card) {
        match = false
        checkMatch(card)
        if let chosenIndex = deck.firstIndex(where: {$0.id == card.id}) {
            if selectedCards.count < setNumber  && !deck[chosenIndex].isSelected && deck[chosenIndex].isDealt {
                deck[chosenIndex].isSelected = true
                selectedCards.append(deck[chosenIndex])
                if selectedCards.count == setNumber && isMatch {
                    match = true
                }
            }
        }
    }
    
    mutating private func checkMatch(_ card: Card) {
        if selectedCards.count == setNumber && isMatch {
            if deck.count >= setNumber {
                replaceMatch()
            } else {
                removeCards()
                selectedCards = []
            }
        } else if selectedCards.count == setNumber {
            for card in selectedCards {
                deselectCard(card)
            }
        }
    }
    
    
    mutating func deselectCard(_ card: Card) {
        if let chosenIndex = deck.firstIndex(where: {$0.id == card.id}) {
            deck[chosenIndex].isSelected = false
            if let selectedIndex = selectedCards.firstIndex(where: {$0.id == card.id}) {
                selectedCards.remove(at: selectedIndex)
            }
        }
        
    }
    
    mutating func replaceMatch() {
        for selectedCard in selectedCards {
            if let index = deck.firstIndex(where: { $0.id == selectedCard.id }) {
                deck[index].isMatched = true
                deck[index].isSelected = false
                matchedList.append(deck[index])
            }
        }
        selectedCards = []
    }
    
    struct Card: Identifiable, CustomDebugStringConvertible{
        let shape: String
        let shapeCount: Int
        let colour: Colour
        let shading: String
        var isFaceUp = false {
            willSet {
                if newValue {
                    isDealt = true
                }
            }
        }
        var isSelected = false
        var isDealt = false
        var isMatched = false
        
        let id: String
        var debugDescription: String {
                    "\(id): \(shape) \(isSelected ? " IsSelected" : " NotSelected") \(shading) \(shapeCount) \(isDealt ? " IsDealt" : " NotDealt")"
                }
    }
}
