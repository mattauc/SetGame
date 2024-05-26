//
//  ContentView.swift
//  Set
//
//  Created by Matthew Auciello on 24/5/2024.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var SetViewModel: SetViewModel
    
    var body: some View {
        VStack {
            cards
            buttons
        }
        .background(Color.blue)
    }

    private var cards: some View {
        AspectVGrid(SetViewModel.cards, aspectRatio: 2/3) { card in
            CardView(card)
                .padding(3)
                .onTapGesture {
                    SetViewModel.selectCard(card)
                }
        }
    }
    
    private var buttons: some View {
        HStack {
            Button(action: {
                SetViewModel.drawMore()
            }, label: {
                Image(systemName: "lanyardcard")
            })
            .foregroundColor(.black)
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
}


struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(SetViewModel: SetViewModel())
    }
}
