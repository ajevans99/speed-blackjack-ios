//
//  DataController.swift
//  BlackJack
//
//  Created by Austin Evans on 4/14/21.
//

import Foundation
import Combine

class DataController: ObservableObject {
    // Game state
    @Published var gameState: GameState = .betting
    @Published var balance = 2500
    @Published var bettingAmount = 0

    // Cards
    @Published var playerCards: [CardState] = []
    @Published var dealerCards: [CardState] = []

    // Split
    @Published var splitCards: [CardState] = []

    var splittable: Bool {
        playerCards.count == 2 && playerCards.first == playerCards.last
    }

    init() {
        change(to: .betting)
    }

    func reset() {
        playerCards = [.hidden, .hidden]
        dealerCards = [.hidden, .hidden]
    }

    func deal() {
        playerCards = [.random, .random]
        dealerCards = [.random, .hidden]

        print(playerCards)
    }

    func dealDealerCard() {
        dealerCards.append(.random)
        if dealerCards.blackJackCount.maxAmount < 17 {
            dealDealerCard()
        }
    }

    func stand() {
        change(to: .dealerTurn)
    }

    func hit() {
        objectWillChange.send()
        print("hit")
        let newCardState = CardState.random
//        print(newCardState)
//        print(playerCards.map { $0.hashValue })
//        print(newCardState.hashValue)
        playerCards.append(newCardState)
//        print(playerCards)
    }

    func split() {
        print("split")
    }

    func double() {
        print("double")
        playerCards.append(.random)
        bettingAmount *= 2
        change(to: .dealerTurn)
    }

    func change(to newState: GameState) {
        switch newState {
        case .betting:
            reset()
        case .playerTurn:
            balance -= bettingAmount
            deal()
        case .dealerTurn:
            _ = dealerCards.popLast()
            dealDealerCard()
        }
        gameState = newState
    }
}
