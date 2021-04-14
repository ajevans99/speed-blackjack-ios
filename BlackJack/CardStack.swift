//
//  CardStack.swift
//  BlackJack
//
//  Created by Austin Evans on 4/13/21.
//

import SwiftUI

struct CardStack: View {
    var cardSize: CGFloat = 150
    var cards: [CardState] = [.showing(.init()), .hidden]

    var body: some View {
        ZStack {
            ForEach(0..<cards.count) { index in
                CardView(card: cards[index])
                    .frame(width: cardSize, height: cardSize)
                    .offset(x: CGFloat(index) * cardSize / 2.5)
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
                .offset(x: cardSize / 2, y: cardSize / 2)
        }
    }
}

enum BlackjackCount {
    case soft(Int)
    case hard(Int)
    case blackjack

    var displayText: String {
        switch self {
        case .soft(let value):
            return "\(value - 10)/\(value)"
        case .hard(let value):
            return "\(value)"
        case .blackjack:
            return "21"
        }
    }
}

extension Array where Element == CardState {
    var blackJackCount: BlackjackCount {
        guard count == 2 else {
            fatalError("Cannot calculate black jack value for array length greater than 3")
        }

        switch (first!, last!) {
        case (.showing(let card1), .showing(let card2)):
            switch (card1.value, card2.value) {
            case (.ace, .ace):
                return .hard(2)
            case (.ace, .jack), (.ace, .queen), (.ace, .king),
                 (.jack, .ace), (.queen, .ace), (.king, .ace),
                 (.ace, .number(10)), (.number(10), .ace):
                return .blackjack
            case (.ace, .number(let value)), (.number(let value), .ace):
                return .soft(value + 11)
            case (.number(let value1), .number(let value2)):
                return .hard(value1 + value2)
            case (.number(let value), _), (_, .number(let value)):
                // One number, one 10
                return .hard(value + 10)
            default:
                // Must be double 10s by this point
                return .hard(20)
            }
        case (.showing(let card), .hidden):
            switch card.value {
            case .ace:
                return .soft(11)
            case .jack, .king, .queen:
                return .hard(10)
            case .number(let value):
                return .hard(value)
            }
        default:
            fatalError("Unhandled blackjack value state")
        }
    }
}

struct CardStack_Previews: PreviewProvider {
    static var previews: some View {
        CardStack()
    }
}
