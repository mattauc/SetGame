//
//  SetGame.swift
//  Set
//
//  Created by Matthew Auciello on 24/5/2024.
//

import Foundation

struct SetGame<Colour: Equatable> {
    //private(set) var cards: Array<Card>
    private(set) var deck:  Array<Card>
    private var selectedCards: Array<Card>
    private(set) var cardIndex = 0
    private var setNumber = 3
    private(set) var numberToDraw: Int

    
    init(shapes: [String], colours: [Colour], shades: [String], gameSize: Int) {
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
        numberToDraw = 12
        selectedCards = []
        deck.shuffle()
    }
    
    var isMatch: Bool {
        return hasExactlyOneMatch(
            selectedCards[0].shape == selectedCards[1].shape && selectedCards[1].shape == selectedCards[2].shape,
            selectedCards[0].shading == selectedCards[1].shading && selectedCards[1].shading == selectedCards[2].shading,
            selectedCards[0].shapeCount == selectedCards[1].shapeCount && selectedCards[1].shapeCount == selectedCards[2].shapeCount,
            selectedCards[0].colour == selectedCards[1].colour && selectedCards[1].colour == selectedCards[2].colour
        )
    }

    func hasExactlyOneMatch(_ matches: Bool...) -> Bool {
        return true
        //matches.filter { $0 }.count == 1
    }
    

    mutating func dealCards() -> Array<Card> {
        var dealingDeck: Array<Card> = []
        if (numberToDraw + cardIndex) < deck.count {
            for index in cardIndex..<numberToDraw+cardIndex {
                print(index)
                deck[index].isDealt = true
                dealingDeck.append(deck[index])
                cardIndex += 1
            }
        }
        if numberToDraw == 12 {
            numberToDraw = 3
        }
        return dealingDeck
    }
    
    mutating func removeCards(numberToRemove: Int) {
        for selectedCard in selectedCards {
            if let index = deck.firstIndex(where: { $0.id == selectedCard.id }) {
                deck.remove(at: index)
            }
        }
    }
    
    mutating func selectCard(_ card: Card) {
        checkMatch(card)
        if let chosenIndex = deck.firstIndex(where: {$0.id == card.id}) {
            if selectedCards.count < setNumber  && !deck[chosenIndex].isSelected{
                deck[chosenIndex].isSelected = true
                selectedCards.append(deck[chosenIndex])
            }
        }
    }
    
    mutating private func checkMatch(_ card: Card) {
        if selectedCards.count == setNumber && isMatch {
            if deck.count >= setNumber {
                replaceMatch()
            } else {
                removeCards(numberToRemove: selectedCards.count)
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
                deck.remove(at: index)
            }
        }
        selectedCards = []
    }
    
    struct Card: Identifiable, CustomDebugStringConvertible{
        let shape: String
        let shapeCount: Int
        let colour: Colour
        let shading: String
        var isSelected = false
        var isDealt = false
        
        let id: String
        var debugDescription: String {
                    "\(id): \(shape) \(isSelected ? " IsSelected" : " NotSelected") \(shading) \(shapeCount) \(isDealt ? " IsDealt" : " NotDealt")"
                }
    }
}
