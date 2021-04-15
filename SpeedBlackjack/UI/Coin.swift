//
//  Coin.swift
//  SpeedBlackjack
//
//  Created by Austin Evans on 4/15/21.
//

import SwiftUI

struct Coin: View {
    @EnvironmentObject var gameController: GameController

    static let size: CGFloat = 80

    let amount: Int

    var body: some View {
        Image("coin-\(amount)")
            .resizable()
            .frame(width: Self.size, height: Self.size)
            .accessibility(addTraits: .isButton)
            .onTapGesture {
                gameController.bettingAmount += amount
            }

    }
}

struct Coin_Previews: PreviewProvider {
    static var previews: some View {
        Coin(amount: 500)
    }
}
