//
//  CoinDeck.swift
//  BlackJack
//
//  Created by Austin Evans on 4/13/21.
//

import SwiftUI

struct CoinDeck: View {
    @EnvironmentObject var gameController: GameController

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    gameController.bettingAmount = 0
                }, label: {
                    Text("Clear")
                        .frame(minWidth: 100)
                        .padding()
                        .background(Color.white.cornerRadius(8))
                })

                Button(action: {
                    gameController.change(to: .playerTurn)
                }, label: {
                    Text("Deal")
                        .frame(minWidth: 100)
                        .padding()
                        .background(Color.white.cornerRadius(8))
                })
            }
            HStack {
                Coin(amount: 500)
                Coin(amount: 100)
                Coin(amount: 50)
                Coin(amount: 10)
            }
            .padding(.horizontal)
        }
    }
}

struct CoinDeck_Previews: PreviewProvider {
    static var previews: some View {
        CoinDeck()
            .background(Color("background"))
    }
}
