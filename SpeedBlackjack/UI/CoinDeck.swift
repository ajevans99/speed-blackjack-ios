//
//  CoinDeck.swift
//  BlackJack
//
//  Created by Austin Evans on 4/13/21.
//

import SwiftUI

struct Coin: View {
    @EnvironmentObject var dataController: DataController

    static let size: CGFloat = 80

    let amount: Int

    var body: some View {
        Image("coin-\(amount)")
            .resizable()
            .frame(width: Self.size, height: Self.size)
            .accessibility(addTraits: .isButton)
            .onTapGesture {
                dataController.bettingAmount += amount
            }

    }
}

struct CoinDeck: View {
    @EnvironmentObject var dataController: DataController

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    dataController.bettingAmount = 0
                }, label: {
                    Text("Clear")
                        .frame(minWidth: 100)
                        .padding()
                        .background(Color.white.cornerRadius(8))
                })

                Button(action: {
                    dataController.change(to: .playerTurn)
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
