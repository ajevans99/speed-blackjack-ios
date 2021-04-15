//
//  DealerCardStack.swift
//  SpeedBlackjack
//
//  Created by Austin Evans on 4/15/21.
//

import SwiftUI

struct DealerCardStack: View {
    @EnvironmentObject var gameController: GameController

    var body: some View {
        CardStack(cards: $gameController.dealerCards,
                  didBust: gameController.dealerBust)
            .padding(.bottom, 32)
    }
}

struct DealerCardStack_Previews: PreviewProvider {
    static var previews: some View {
        DealerCardStack()
    }
}
