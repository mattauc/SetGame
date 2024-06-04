//
//  SetTests.swift
//  SetTests
//
//  Created by Matthew Auciello on 4/6/2024.
//

import XCTest
@testable import Set

final class SetTests: XCTestCase {
    
    let gameColours: [CustomColour] = [CustomColour.red, CustomColour.purple, CustomColour.green]
    let gameShapes: [String] = ["diamond", "rectangle", "ellipse"]
    let gameShading: [String] = ["solid", "striped", "open"]
    let gameSize: Int = 81
    var setModel: SetGame<CustomColour>!
    typealias Card = SetGame<CustomColour>.Card
    
    override func setUpWithError() throws {
        setModel = SetGame(shapes: gameShapes, colours: gameColours, shades: gameShading, gameSize: gameSize, numberToDraw: 81)
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDeckSize() throws {
        XCTAssertTrue(setModel.deck.count == 81)
    }
    
    func testCardSetIsMatchOne() throws {
        _ = setModel.dealCards()
        let first = findCard(1, "diamond", "striped", CustomColour.red)
        let second = findCard(2, "diamond", "solid", CustomColour.red)
        let third = findCard(3, "diamond", "open", CustomColour.red)
        setModel.selectCard(first!)
        setModel.selectCard(second!)
        setModel.selectCard(third!)
        
        XCTAssertTrue(setModel.isMatch == true)
    }
    
    func testCardSetIsMatchTwo() throws {
        _ = setModel.dealCards()
        let first = findCard(1, "ellipse", "striped", CustomColour.purple)
        let second = findCard(2, "diamond", "solid", CustomColour.green)
        let third = findCard(3, "rectangle", "open", CustomColour.red)
        setModel.selectCard(first!)
        setModel.selectCard(second!)
        setModel.selectCard(third!)
        
        XCTAssertTrue(setModel.isMatch == true)
    }
    
    
    func testCardSetIsNotMatch() throws {
        _ = setModel.dealCards()
        let first = findCard(1, "diamond", "striped", CustomColour.red)
        let second = findCard(2, "rectangle", "solid", CustomColour.red)
        let third = findCard(3, "diamond", "open", CustomColour.purple)
        setModel.selectCard(first!)
        setModel.selectCard(second!)
        setModel.selectCard(third!)
        
        XCTAssertTrue(setModel.isMatch == false)
    }
    
    func testRemoveCards() throws {
        _ = setModel.dealCards()
        let first = findCard(1, "ellipse", "striped", CustomColour.purple)
        let second = findCard(2, "diamond", "solid", CustomColour.green)
        
        setModel.selectCard(first!)
        setModel.selectCard(second!)
        
        setModel.removeCards()
        XCTAssertTrue(setModel.deck.count == 79)
    }
    
    func testReplaceMatch() throws {
        _ = setModel.dealCards()
        let first = findCard(1, "ellipse", "striped", CustomColour.purple)
        let second = findCard(2, "diamond", "solid", CustomColour.green)
        let third = findCard(3, "rectangle", "open", CustomColour.red)
        setModel.selectCard(first!)
        setModel.selectCard(second!)
        setModel.selectCard(third!)
        
        setModel.replaceMatch()
        XCTAssertTrue(setModel.matchedList.count == 3)
    }
    
    func testSelectCard() throws {
        _ = setModel.dealCards()
        let first = findCard(1, "ellipse", "striped", CustomColour.purple)
        setModel.selectCard(first!)
        
        
        if let chosenIndex = setModel.deck.firstIndex(where: {$0.id == first!.id}) {
            XCTAssertTrue(setModel.deck[chosenIndex].isSelected == true)
        } else {
            XCTAssertTrue(false)
        }
    }
    
    func testDeselectCard() throws {
        _ = setModel.dealCards()
        let first = findCard(1, "ellipse", "striped", CustomColour.purple)
        setModel.selectCard(first!)
        setModel.deselectCard(first!)
      
        if let chosenIndex = setModel.deck.firstIndex(where: {$0.id == first!.id}) {
            XCTAssertTrue(setModel.deck[chosenIndex].isSelected == false)
        } else {
            XCTAssertTrue(false)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}

extension SetTests {
    func findCard(_ count: Int,_ shape: String,_ shading: String,_ colour: CustomColour) -> Card? {
        for newCard in setModel.deck {
            if newCard.shapeCount == count && newCard.shading == shading && newCard.colour == colour && newCard.shape == shape {
                return newCard
            }
        }
        return nil
    }
}
