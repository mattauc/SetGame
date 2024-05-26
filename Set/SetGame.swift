//
//  SetGame.swift
//  Set
//
//  Created by Matthew Auciello on 24/5/2024.
//

import Foundation

struct SetGame<Colour> {
    private(set) var cards: Array<Card>
    //private(set) var playingCards: Array<Card> = []
    private var numberOfSelected = 0
    private(set) var numberToDraw = 12
    private var listOfCombinations: [(Int, String, Colour, String)]
    
    
    init(shapes: [String], colours: [Colour], shades: [String], gameSize: Int) {
        listOfCombinations = []
        cards = []
        for index in 1..<4 {
            for selectShape in shapes {
                for selectColour in colours {
                    for selectShade in shades {
                        listOfCombinations.append((index, selectShape, selectColour, selectShade))
                    }
                }
            }
        }
        //numberToDraw = 12
        buildCards(numberToDraw: 12)
    }
    
    mutating func buildCards(numberToDraw: Int) {
        for _ in 0..<numberToDraw {
            let randomIndex = Int.random(in: 0...80)
            let combination = listOfCombinations[randomIndex]
            if cards.count + numberToDraw <= 81 {
                cards.append(Card(shape: combination.1, shapeCount: combination.0, colour: combination.2, shading: combination.3, id: String(cards.count)))
            }
        }
    }
    
    mutating func selectCard(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            if numberOfSelected < 3 {
                cards[chosenIndex].isSelected = true
                numberOfSelected += 1
            }
        }
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
