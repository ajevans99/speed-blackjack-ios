//
//  CoinView.swift
//  BlackJack
//
//  Created by Austin Evans on 4/13/21.
//

import SwiftUI

struct Card {
    enum Suit: CaseIterable {
        case heart
        case diamond
        case spade
        case club

        var imageName: String {
            switch self {
            case .heart:
                return "suit.heart.fill"
            case .diamond:
                return "suit.diamond.fill"
            case .spade:
                return "suit.spade.fill"
            case .club:
                return "suit.club.fill"
            }
        }

        var color: Color {
            switch self {
            case .club, .spade:
                return .black
            case .heart, .diamond:
                return .red
            }
        }
    }

    enum Value {
        static let allCases: [Value] = [
            .ace, .king, queen, .jack
        ] + (2...10).map { .number($0) }

        case ace
        case king
        case queen
        case jack
        case number(Int)

        var display: String {
            switch self {
            case .ace:
                return "A"
            case .king:
                return "K"
            case .queen:
                return "Q"
            case .jack:
                return "J"
            case .number(let value):
                return "\(value)"
            }
        }
    }

    let value: Value
    let suit: Suit

    init() {
        value = Value.allCases.randomElement()!
        suit = Suit.allCases.randomElement()!
    }

    init(value: Value, suit: Suit) {
        self.value = value
        self.suit = suit
    }
}

enum CardState {
    case hidden
    case showing(Card)
}

struct CardView: View {
//    var card: CardState = .hidden
    var card: CardState = .showing(Card())

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
        switch card {
        case .hidden:
            Image("card-back")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geo.size.width, height: geo.size.height)
        case .showing(let card):
            HStack {
                VStack {
                    Text(card.value.display)
                    Image(systemName: card.suit.imageName)
                    Spacer()
                }
                .padding(10)
                Spacer()
            }
            .font(.system(size: geo.size.height / 5))
            .foregroundColor(card.suit.color)
        }
    }
}

struct CoinView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
            .frame(width: 100, height: 100)
            .background(Color.black)
    }
}
