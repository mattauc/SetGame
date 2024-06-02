//
//  Cardify.swift
//  Set
//
//  Created by Matthew Auciello on 31/5/2024.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    typealias Card = SetGame<CustomColour>.Card
    let card: Card
    init(card: Card) {
        rotation = card.isFaceUp ? 0 : 180
        self.card = card
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    var rotation: Double
    
    var animatableData: Double {
        get {rotation}
        set {rotation = newValue }
    }
    
    @State var attempts: Int = 0

    func body(content: Content) -> some View {
         ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base.strokeBorder(lineWidth: Constants.lineWidth)
                .background(base.fill(.white))
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            base.fill(Color.mint)
                .strokeBorder(lineWidth: Constants.lineWidth)
                .opacity(isFaceUp ? 0 : 1)
        }
        .modifier(Shake(animatableData: CGFloat(attempts)))
        .rotation3DEffect(.degrees(rotation), axis: (0,1,0))
        .highlightOnSelect(isSelected: card.isSelected)
        .onChange(of: card.isSelected) { newValue, oldValue in
            if newValue && !card.isMatched {
                withAnimation(.default) {
                    self.attempts += 1
                }
            }
        }
        .frame(minWidth: Constants.minCardWidth, maxWidth: .infinity, minHeight: Constants.minCardHeight, maxHeight: .infinity)
    }
    
    
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 4
        static let minCardWidth: CGFloat = 70
        static let minCardHeight: CGFloat = 100
    }
    
    struct Shake: GeometryEffect {
        
        var amount: CGFloat = 5
        var shakesPerUnit = 3
        var animatableData: CGFloat
        
        func effectValue(size: CGSize) -> ProjectionTransform {
                ProjectionTransform(CGAffineTransform(translationX:
                    amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
                    y: 0))
            }
    }
}

extension View {
    func cardify(card: SetGame<CustomColour>.Card) -> some View {
        modifier(Cardify(card: card))
    }
    
    func highlightOnSelect(isSelected: Bool) -> some View {
            if isSelected {
                return foregroundColor(Color.yellow)
            } else {
                return foregroundColor(.black)
            }
        }
}
