//
//  Cardify.swift
//  Set
//
//  Created by Matthew Auciello on 31/5/2024.
//

import SwiftUI

struct Cardify: ViewModifier {
    typealias Card = SetGame<CustomColour>.Card
    let card: Card

    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base.strokeBorder(lineWidth: Constants.lineWidth)
                .background(base.fill(.white))
                .overlay(content)
        }
        .highlightOnSelect(isSelected: card.isSelected)
        .frame(minWidth: 70, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 4
    }
}

extension View {
    func cardify(card: SetGame<CustomColour>.Card) -> some View {
        modifier(Cardify(card: card))
    }
}

extension View {
    func highlightOnSelect(isSelected: Bool) -> some View {
        if isSelected {
            return foregroundColor(Color.yellow)
        } else {
            return foregroundColor(.black)
        }
    }
}
