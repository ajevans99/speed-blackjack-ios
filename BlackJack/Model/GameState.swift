//
//  GameState.swift
//  BlackJack
//
//  Created by Austin Evans on 4/14/21.
//

import Foundation

enum GameState: Equatable {
    enum OutcomeState: Equatable {
        case dealerWin
        case playerWin
        case dealerBust
        case playerBust
        case push
        case playerBlackjack
        case dealerBlackjack
        case multiple([OutcomeState])

        var description: String {
            switch self {
            case .dealerWin:
                return "House wins 🙁"
            case .playerWin:
                return "You win! 🎉"
            case .dealerBust:
                return "You win. Dealer busted. 🥳"
            case .playerBust:
                return "House wins. You busted. 🪦"
            case .push:
                return "Push. 👉👈"
            case .playerBlackjack:
                return "Wooo! You got a Blackjack! 🎰"
            case .dealerBlackjack:
                return "No luck. House Blackjack. 🎰"
            case .multiple(let outcomes):
                return outcomes.enumerated().reduce(into: "") { (acc, element) in
                    let (index, outcome) = element
                    acc += "\(index + 1)) \(outcome.description)\n"
                }
            }
        }
    }

    case betting

    case playerTurn
    case dealerTurn

    case outcome(OutcomeState)

    var description: String {
        switch self {
        case .betting, .playerTurn, .dealerTurn:
            return "\(self)"
        case .outcome(let outcome):
            return "Outcome: \(outcome.description)"
        }
    }
}
