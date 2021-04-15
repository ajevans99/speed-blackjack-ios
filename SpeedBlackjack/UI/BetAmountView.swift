//
//  BetAmountView.swift
//  BlackJack
//
//  Created by Austin Evans on 4/14/21.
//

import SwiftUI

struct BetAmountView: View {
    @EnvironmentObject var gameController: GameController

    var body: some View {
        HStack {
            Image("bet-coin")
                .resizable()
                .frame(width: 30, height: 30)
            Text("$\(gameController.bettingAmount)")
                .bold()
                .foregroundColor(.white)
        }
    }
}

struct BetAmountView_Previews: PreviewProvider {
    static var previews: some View {
        BetAmountView()
    }
}
