//
//  SetGame.swift
//  Set
//
//  Created by Matthew Auciello on 24/5/2024.
//

import Foundation

struct SetGame<Colour> {
    private(set) var cards: Array<Card>
    private(set) var numberToDraw = 12
    private var listOfCombinations: [(Int, String, Colour, String)]
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
        return true
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
