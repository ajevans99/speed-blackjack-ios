//
//  CardStack.swift
//  BlackJack
//
//  Created by Austin Evans on 4/13/21.
//

import SwiftUI

struct CardStack: View {
    var cardSize: CGFloat = 150

    @Binding var cards: [CardState]

    var body: some View {
        ZStack {
            ForEach(Array(cards.enumerated()), id: \.0) { (index, card) in
                CardView(card: card)
                    .frame(width: cardSize, height: cardSize)
                    .offset(x: CGFloat(index) * cardSize / 2.5)
                    .onTapGesture {
                        print("test")
                    }
            }

            Text("\(cards.blackJackCount.displayText)")
                .foregroundColor(.black)
                .padding()
                .background(
                    Ellipse()
                        .strokeBorder(Color.orange, lineWidth: 5)
                        .background(
                            Ellipse().fill(Color.yellow)
                        )
                )
                .offset(x: (cardSize / 2.5) * CGFloat(cards.count - 1),
                        y: cardSize / 2)
        }
        .offset(x: -(CGFloat(cards.count - 2) * cardSize / 2.5) / 2)
    }
}


struct CardStack_Previews: PreviewProvider {
    @State static var cards = [CardState.random, CardState.hidden]

    static var previews: some View {
        CardStack(cards: $cards)
    }
}
