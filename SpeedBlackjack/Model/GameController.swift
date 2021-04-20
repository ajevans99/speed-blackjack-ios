//
//  GameController.swift
//  BlackJack
//
//  Created by Austin Evans on 4/14/21.
//

import Foundation
import Combine

class GameController: ObservableObject {
    // Directions
    @Published var showDirections = false
    @Published var showSettings = false

    // Game states
    @Published var gameState: GameState = .betting
    @Published var balance = 2500
    @Published var bettingAmount = 50

    // Cards
    @Published var playerCards = [CardState]()
    @Published var dealerCards = [CardState]()

    // Busts
    @Published var playerBust = false
    @Published var dealerBust = false
    @Published var splitBust = false

    // Split
    @Published var splitCards = [CardState]()
    @Published var splitDeckActive = false

    var isSplit: Bool {
        !splitCards.isEmpty
    }

    var actionsEnabled: Bool {
        gameState == .playerTurn
    }

    var splittable: Bool {
        actionsEnabled &&
            playerCards.count == 2 &&
            playerCards.first!.card.isEquivalentInValue(to: playerCards.last!.card) &&
            !isSplit // Prevents double split
    }

    var doubleable: Bool {
        actionsEnabled && ((playerCards.count == 2 && !splitDeckActive) ||
                            (splitCards.count == 2 && splitDeckActive))
    }

    init() {
        change(to: .betting)
    }

    func reset() {
        playerCards = [.init(card: .init(value: .ace, suit: .diamond), isHidden: true), .init(card: .init(value: .ace, suit: .spade), isHidden: true)]
        dealerCards = [.init(isHidden: true), .init(isHidden: true)]
        splitCards = []

        playerBust = false
        dealerBust = false
        splitBust = false
    }

    func deal() {
        playerCards.forEach { $0.isHidden.toggle() }
        dealerCards.first?.isHidden.toggle()

        if playerCards.blackJackCount == .blackjack {
            print("Player Blackjack!")
            change(to: .dealerTurn)
            return
        }

        if dealerCards[0].card.value == .ace, dealerCards[1].card.value.number == 10 {
            print("Dealer blackjack!")
            change(to: .dealerTurn)
        }

        print(playerCards)
    }

    func dealDealerCard() {

        while !playerBust,
           dealerCards.blackJackCount.amount < 17,
           playerCards.blackJackCount != .blackjack {
            dealerCards.append(.init(isHidden: false))
        }

        let dealerCardsCount = dealerCards.blackJackCount.amount
        let playerCardsCount = playerCards.blackJackCount.amount

        let outcome: GameState.OutcomeState

        if playerCardsCount > 21 {
            outcome = .playerBust
        } else if dealerCardsCount == playerCardsCount {
            outcome = .push
        } else if dealerCardsCount == 21 && dealerCards.count == 2 {
            outcome = .dealerBlackjack
        } else if playerCardsCount == 21 && playerCards.count == 2 {
            outcome = .playerBlackjack
        } else if dealerCardsCount > 21 {
            dealerBust = true
            outcome = .dealerBust
        } else if playerCardsCount > dealerCardsCount {
            outcome = .playerWin
        } else {
            outcome = .dealerWin
        }

        if isSplit {
            change(to: .outcome(.multiple([outcome, splitOutcome()])))
        } else {
            change(to: .outcome(outcome))
        }
    }

    func stand() {
        guard gameState == .playerTurn else { return }

        if isSplit && !splitDeckActive {
            splitDeckActive = true
        } else {
            change(to: .dealerTurn)
        }
    }

    func hit() {
        guard gameState == .playerTurn else { return }

        print("hit")

        if splitDeckActive {
            splitCards.append(.init(isHidden: false))

            let cardCount = splitCards.blackJackCount.amount

            if cardCount > 21 {
                print("Player bust")
                splitBust = true
                change(to: .dealerTurn)
            }

            if cardCount == 21 {
                print("Auto-stand on 21")
                change(to: .dealerTurn)
            }
        } else {
            playerCards.append(.init(isHidden: false))

            let cardCount = playerCards.blackJackCount.amount

            if cardCount > 21 {
                print("Player bust")
                playerBust = true

                if isSplit && !splitDeckActive {
                    splitDeckActive = true
                } else {
                    change(to: .dealerTurn)
                }
            }

            if cardCount == 21 {
                print("Auto-stand on 21")
                if isSplit && !splitDeckActive {
                    splitDeckActive = true
                } else {
                    change(to: .dealerTurn)
                }
            }
        }
    }

    func split() {
        guard gameState == .playerTurn, splittable else { return }
        print("split")

        splitCards.append(playerCards.popLast()!)

        // Deal random new cards
        splitCards.append(.init(isHidden: false))
        hit() // does append to player cards

        balance -= bettingAmount
    }

    func double() {
        guard gameState == .playerTurn, doubleable else { return }
        print("double")

        if splitDeckActive {
            splitCards.append(.init(isHidden: false))
        } else {
            playerCards.append(.init(isHidden: false))
        }

        // TODO: Handle double balance for split case
        balance -= bettingAmount
        bettingAmount *= 2

        if splitDeckActive {
            splitBust = playerCards.blackJackCount.amount > 21
        } else {
            playerBust = playerCards.blackJackCount.amount > 21
        }

        print("Player bust")

        if isSplit && !splitDeckActive {
            splitDeckActive = true
        } else {
            change(to: .dealerTurn)
        }
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
            splitDeckActive = false
//            _ = dealerCards.popLast()
            dealerCards.last?.isHidden = false
            dealDealerCard()
        case .outcome(let outcome):
            print(outcome)
            updateBalance(for: outcome)
        }
        print("New state \(newState)")
    }

    func splitOutcome() -> GameState.OutcomeState {
        let splitCardsCount = splitCards.blackJackCount.amount
        let dealerCardsCount = dealerCards.blackJackCount.amount

        if splitCardsCount == 21 && splitCards.count == 2 {
            return .playerBlackjack
        } else if splitCardsCount > 21 {
            return .playerBust
        } else if dealerCardsCount == splitCardsCount {
            return .push
        } else if splitCardsCount > dealerCardsCount {
            return .playerWin
        } else if dealerCardsCount > 21 {
            return .dealerBust
        } else {
            return .dealerWin
        }
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
        case .multiple(let outcomes):
            outcomes.forEach { updateBalance(for: $0) }
        }
    }
}
