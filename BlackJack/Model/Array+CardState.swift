//
//  Array+CardState.swift
//  BlackJack
//
//  Created by Austin Evans on 4/14/21.
//

import Foundation

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

    var amount: Int {
        switch self {
        case .soft(let amount), .hard(let amount):
            return amount
        case .blackjack:
            return 21
        }
    }
}

extension Array where Element == CardState {
    var blackJackCount: BlackjackCount {
        let sum = reduce(into: 0) { (acc, cardState) in
            switch cardState {
            case .showing(let card):
                acc += card.value.number
            case .hidden:
                break
            }
        }

        let containsAce = contains { cardState -> Bool in
            switch cardState {
            case .showing(let card):
                return card.value == .ace
            default:
                return false
            }
        }

        if containsAce, count == 2, sum == 11 {
            return .blackjack
        }

        if containsAce, sum < 12 {
            return .soft(sum + 10)
        }

        return .hard(sum)
    }
}
