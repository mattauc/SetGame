//
//  SetGame.swift
//  Set
//
//  Created by Matthew Auciello on 24/5/2024.
//

import Foundation

struct SetGame<Colour: Equatable> {
    private(set) var cards: Array<Card>
    private(set) var numberToDraw = 12
    private(set) var listOfCombinations: [(Int, String, Colour, String)]
    private var selectedCards: Array<Card>
    
    
    init(shapes: [String], colours: [Colour], shades: [String], gameSize: Int) {
        listOfCombinations = []
        cards = []
        selectedCards = []
        for index in 1..<4 {
            for selectShape in shapes {
                for selectColour in colours {
                    for selectShade in shades {
                        listOfCombinations.append((index, selectShape, selectColour, selectShade))
                    }
                }
            }
        }
        buildCards(numberToDraw: numberToDraw)
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
        return matches.filter { $0 }.count == 1
    }
    
    mutating func makeNewCard(randomIndex: Int) -> Card? {
        let combination = listOfCombinations[randomIndex]
        if listOfCombinations.count > 0 {
            let newCard = Card(shape: combination.1, shapeCount: combination.0, colour: combination.2, shading: combination.3, id: String(listOfCombinations.count))
            listOfCombinations.remove(at: randomIndex)
            return newCard
        }
        return nil
    }
    
    mutating func buildCards(numberToDraw: Int) {
        if listOfCombinations.count >= numberToDraw {
            for _ in 0..<numberToDraw {
                let randomIndex = Int.random(in: 0...listOfCombinations.count-1)
                if let newCard = makeNewCard(randomIndex: randomIndex) {
                    cards.append(newCard)
                }
            }
        }
    }
    
    mutating func removeCards(numberToRemove: Int) {
        for selectedCard in selectedCards {
            if let index = cards.firstIndex(where: { $0.id == selectedCard.id }) {
                cards.remove(at: index)
            }
        }
    }
    
    mutating func selectCard(_ card: Card) {
        if selectedCards.count == 3 && isMatch {
            if listOfCombinations.count >= 3 {
                replaceMatch()
            } else {
                removeCards(numberToRemove: selectedCards.count)
                selectedCards = []
            }
        } else if selectedCards.count == 3 {
            for card in selectedCards {
                deselectCard(card)
            }
        }
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            if selectedCards.count < 3  && !cards[chosenIndex].isSelected{
                cards[chosenIndex].isSelected = true
                selectedCards.append(cards[chosenIndex])
            }
        }
    }
    
    
    mutating func deselectCard(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            cards[chosenIndex].isSelected = false
            if let selectedIndex = selectedCards.firstIndex(where: {$0.id == card.id}) {
                selectedCards.remove(at: selectedIndex)
            }
        }
        
    }
    
    mutating func replaceMatch() {
        for selectedCard in selectedCards {
            if let index = cards.firstIndex(where: { $0.id == selectedCard.id }) {
                let random = Int.random(in: 0...listOfCombinations.count-1)
                if let newCard = makeNewCard(randomIndex: random) {
                    cards[index] = newCard
                }
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
        
        let id: String
        var debugDescription: String {
                    "\(id): \(shape) \(isSelected ? " IsSelected" : " NotSelected")"
                }
    }
}
