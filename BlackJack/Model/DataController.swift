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
    @Published var bettingAmount = 50

    // Cards
    @Published var playerCards: [CardState] = []
    @Published var dealerCards: [CardState] = []

    @Published var playerBust = false
    @Published var dealerBust = false

    // Split
    @Published var splitCards: [CardState] = []

    var actionsEnabled: Bool {
        gameState == .playerTurn
    }

    var splittable: Bool {
        actionsEnabled && playerCards.count == 2 && playerCards.first == playerCards.last
    }

    var doubleable: Bool {
        actionsEnabled && playerCards.count == 2
    }

    init() {
        change(to: .betting)
    }

    func reset() {
        playerCards = [.init(isHidden: true), .init(isHidden: true)]
        dealerCards = [.init(isHidden: true), .init(isHidden: true)]

        playerBust = false
        dealerBust = false
    }

    func deal() {
        playerCards.forEach { $0.isHidden.toggle() }
        dealerCards.first?.isHidden.toggle()

        if playerCards.blackJackCount == .blackjack {
            print("Player Blackjack!")
            change(to: .dealerTurn)
        }

        print(playerCards)
    }

    func dealDealerCard() {
        dealerCards.append(.init(isHidden: false))
        if !playerBust,  dealerCards.blackJackCount.amount < 17 {
            dealDealerCard()
            return
        }

        let dealerCardsCount = dealerCards.blackJackCount.amount
        let playerCardsCount = playerCards.blackJackCount.amount

        let outcome: GameState.OutcomeState

        if playerCardsCount > 21 {
            outcome = .playerBust
        } else if dealerCardsCount == playerCardsCount {
            outcome = .push
        } else if dealerCardsCount > 21 {
            dealerBust = true
            outcome = .dealerBust
        } else if dealerCardsCount == 21 && dealerCards.count == 2 {
            outcome = .dealerBlackjack
        } else if playerCardsCount == 21 && playerCards.count == 2 {
            outcome = .playerBlackjack
        } else if playerCardsCount > dealerCardsCount {
            outcome = .playerWin
        } else {
            outcome = .dealerWin
        }

        change(to: .outcome(outcome))
    }

    func stand() {
        guard gameState == .playerTurn else { return }
        change(to: .dealerTurn)
    }

    func hit() {
        guard gameState == .playerTurn else { return }
        objectWillChange.send()
        print("hit")
        playerCards.append(.init(isHidden: false))

        let cardCount = playerCards.blackJackCount.amount

        if cardCount > 21 {
            print("Player bust")
            playerBust = true
            change(to: .dealerTurn)
        }

        if cardCount == 21 {
            print("Auto-stand on 21")
            change(to: .dealerTurn)
        }
    }

    func split() {
        guard gameState == .playerTurn, splittable else { return }
        print("split")
    }

    func double() {
        guard gameState == .playerTurn, doubleable else { return }
        print("double")
        playerCards.append(.init(isHidden: false))
        bettingAmount *= 2
        playerBust = playerCards.blackJackCount.amount > 21
        print("Player bust")
        change(to: .dealerTurn)
    }

    func change(to newState: GameState) {
        gameState = newState
        switch newState {
        case .betting:
            reset()
        case .playerTurn:
            balance -= bettingAmount
            print("New balance \(balance)")
            deal()
        case .dealerTurn:
            _ = dealerCards.popLast()
            dealDealerCard()
        case .outcome(let outcome):
            print(outcome)
            updateBalance(for: outcome)
        }
        print("New state \(newState)")
    }

    func updateBalance(for outcome: GameState.OutcomeState) {
        switch outcome {
        case .playerBlackjack:
            balance += bettingAmount * 2 + Int(ceil(Double(bettingAmount / 2)))
        case .dealerBust, .playerWin:
            balance += bettingAmount * 2
        case .push:
            balance += bettingAmount
        case .dealerBlackjack, .dealerWin, .playerBust:
            print("House win of $\(bettingAmount)")
        }
    }
}
