//
//  Array+CardState.swift
//  BlackJack
//
//  Created by Austin Evans on 4/14/21.
//

import Foundation

enum BlackjackCount: Equatable {
    case soft(Int)
    case hard(Int)
    case blackjack

    var softText: String {
        switch self {
        case .soft(let value):
            return "\(value - 10)/\(value)"
        case .hard(let value):
            return "\(value)"
        case .blackjack:
            return "21"
        }
    }

    var hardText: String {
        switch self {
        case .soft(let value), .hard(let value):
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
            if !cardState.isHidden {
                acc += cardState.card.value.number
            }
        }

        let containsAce = contains {
            !$0.isHidden && $0.card.value == .ace
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
