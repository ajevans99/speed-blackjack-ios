//
//  CardState.swift
//  BlackJack
//
//  Created by Austin Evans on 4/14/21.
//

import Foundation

enum CardState: Hashable, Equatable {
    case hidden
    case showing(Card)

    static var random: CardState {
        return .showing(Card())
    }

    static func == (lhs: CardState, rhs: CardState) -> Bool {
        switch (lhs, rhs) {
        case (hidden, hidden):
            return true
        case (showing(let card1), showing(let card2)):
            return card1.value == card2.value
        case (hidden, showing), (showing, hidden):
            return false
        }
    }
}
