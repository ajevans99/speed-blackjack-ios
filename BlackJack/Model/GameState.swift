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
    }

    case betting

    case playerTurn
    case dealerTurn

    case outcome(OutcomeState)
}
