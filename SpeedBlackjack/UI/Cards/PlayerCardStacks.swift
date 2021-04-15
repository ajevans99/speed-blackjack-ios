//
//  PlayerCardStacks.swift
//  SpeedBlackjack
//
//  Created by Austin Evans on 4/15/21.
//

import SwiftUI

struct PlayerCardStacks: View {
    @EnvironmentObject var gameController: GameController

    var body: some View {
        HStack {
            CardStack(cards: $gameController.playerCards,
                      didBust: gameController.playerBust,
                      showBetAmount: true)
                .padding(.bottom, 16)
                .scaleEffect(
                    gameController.splitDeckActive ||
                        (gameController.isSplit && gameController.gameState != .playerTurn)
                        ? 0.75 : 1)
                .animation(.linear)

            if !gameController.splitCards.isEmpty {
                CardStack(cards: $gameController.splitCards,
                          didBust: gameController.splitBust,
                          showBetAmount: true)
                    .padding(.bottom, 16)
                    .padding(.leading, 32)
                    .scaleEffect(gameController.splitDeckActive ? 1 : 0.75)
                    .animation(.linear)
            }
        }
    }
}

struct PlayerCardStacks_Previews: PreviewProvider {
    static var previews: some View {
        PlayerCardStacks()
    }
}
