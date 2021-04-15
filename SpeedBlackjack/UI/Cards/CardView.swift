//
//  CoinView.swift
//  BlackJack
//
//  Created by Austin Evans on 4/13/21.
//

import SwiftUI

struct CardView: View {
    @Binding var cardState: CardState

    var body: some View {
        GeometryReader { geo in
            RoundedRectangle(cornerRadius: geo.size.height / 8)
                .fill(Color.white)
                .aspectRatio(1/1.4, contentMode: .fit)
                .overlay(
                    overlay(geo: geo)
                )
                .shadow(radius: 10)
        }
    }

    @ViewBuilder func overlay(geo: GeometryProxy) -> some View {
        FlipView(isFlipped: cardState.isHidden) {
            HStack(alignment: .top) {
                VStack {
                    Text(cardState.card.value.display)
                    Image(systemName: cardState.card.suit.imageName)
                    Spacer()
                }
                .transition(.opacity)
                .animation(.easeInOut)
                .padding(10)
                Spacer()
            }
            .font(.system(size: geo.size.height / 5))
            .foregroundColor(cardState.card.suit.color)
        } back: {
            Image("card-back")
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
}
