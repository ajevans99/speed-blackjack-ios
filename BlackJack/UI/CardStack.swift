//
//  CardStack.swift
//  BlackJack
//
//  Created by Austin Evans on 4/13/21.
//

import SwiftUI

struct CardStack: View {
    var cardSize: CGFloat = 150

    @EnvironmentObject var dataController: DataController

    @Binding var cards: [CardState]

    var didBust = false

    var count: String {
        if case .outcome(_) = dataController.gameState {
            return cards.blackJackCount.hardText
        }
        return cards.blackJackCount.softText
    }

    var body: some View {
        ZStack {
            ForEach(cards.indices, id: \.self) { index in
                CardView(cardState: $cards[index])
                    .frame(width: cardSize, height: cardSize)
                    .offset(x: CGFloat(index) * cardSize / 2.5)
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .opacity
                        )
                    )
                    .animation(.linear)
            }
            .transition(.opacity)

            if count != "0" {
                Text(count)
                    .foregroundColor(.black)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(Color.orange, lineWidth: 5)
                            .background(
                                RoundedRectangle(cornerRadius: 8).fill(Color.yellow)
                            )
                    )
                    .transition(.slide)
                    .offset(x: (cardSize / 2.5) * CGFloat(cards.count - 1),
                            y: cardSize / 2)
            }
        }
        .offset(x: -(CGFloat(cards.count - 2) * cardSize / 2.5) / 2)
        .overlay(
            Text("Busted")
                .font(.system(size: 16, weight: .heavy, design: .rounded))
                .foregroundColor(Color.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color("bust"))
                )
                .opacity(didBust ? 1 : 0)
                .animation(.linear)
        )
    }
}


struct CardStack_Previews: PreviewProvider {
    @State static var cards = [CardState(isHidden: false), CardState(isHidden: false)]

    static var previews: some View {
        CardStack(cards: $cards)
    }
}
