//
//  ContentView.swift
//  Set
//
//  Created by Matthew Auciello on 24/5/2024.
//

import SwiftUI

struct SetGameView: View {
    typealias Card = SetGame<CustomColour>.Card
    @ObservedObject var SetViewModel: SetViewModel
    @Namespace private var dealingNameSpace
    @Namespace private var discaringNameSpace
    private let aspectRatio: CGFloat = 2/3
    private let deckWidth: CGFloat = 50
    private let timeInterval = 0.3
    
    
    var body: some View {
        VStack(spacing: 0) {
            cards
            buttons
        }
        .background(Color.blue)
    }
    
    private var cards: some View {
        AspectVGrid(SetViewModel.dealtCards, aspectRatio: aspectRatio) { card in
            if isDealt(card) {
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(3)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: timeInterval)) {
                            SetViewModel.selectCard(card)
                        }
                    }
            }
        }
    }
    
    private var buttons: some View {
        ZStack {
            HStack {
                deck.padding()
                Spacer()
                restartButton
                Spacer()
                discard.padding()
            }
            .foregroundColor(.black)
            .imageScale(.large)
            .font(.largeTitle)
        }
        .background(RoundedRectangle(cornerRadius: 3)
            .fill(.cyan).strokeBorder(lineWidth: 2))
    }
    
    private var restartButton: some View {
        Button(action: {
            SetViewModel.restartGame()
            dealt = Set<Card.ID>()
        }, label: {
            Image(systemName: "restart.circle")
        })
    }
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        SetViewModel.deck.filter {!isDealt($0)}
    }
    
    private var deck: some View {
        ZStack {
            ForEach(SetViewModel.nonDealtCards.reversed()) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio)
        .onTapGesture() {
            let dealingDeck = SetViewModel.drawMore()
            deal(dealingDeck)
        }
    }
    
    private func deal(_ dealingDeck: Array<Card>) {
        var delay: TimeInterval = 0
        for card in dealingDeck {
            withAnimation(.easeInOut(duration: timeInterval).delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += 0.15
        }
    }
    @State private var discarded = Set<Card.ID>()
    
    private var discard: some View {
        ZStack {
            ForEach(SetViewModel.dealtCards) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: discaringNameSpace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio)
    }
}


struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(SetViewModel: SetViewModel())
    }
}
