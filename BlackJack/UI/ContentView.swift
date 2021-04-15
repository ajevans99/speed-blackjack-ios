//
//  ContentView.swift
//  BlackJack
//
//  Created by Austin Evans on 4/13/21.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var dataController: DataController

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color("background")
                    .ignoresSafeArea()

                VStack {
                    HStack {
                        Spacer()
                        MoneyBox(amount: 2500)
                            .frame(width: 200, height: 50)
                    }
                    .padding(.horizontal)
                    Spacer()
                    CardStack(cards: $dataController.dealerCards)
                    Spacer()
                    CardStack(cards: $dataController.playerCards)
                    Spacer()
                    BetAmountView()
                    Spacer()
                    if dataController.gameState == .dealerTurn {
                        Button(action: {
                            dataController.change(to: .betting)
                        }, label: {
                            Text("Rebet")
                                .bold()
                                .foregroundColor(.white)
                        })
                        .frame(minWidth: 100)
                        .padding()
                        .background(Color.white.cornerRadius(8))

                        Button(action: {
                            dataController.change(to: .playerTurn)
                        }, label: {
                            Text("Rebet and deal")
                                .bold()
                                .foregroundColor(.white)
                        })
                        .frame(minWidth: 100)
                        .padding()
                        .background(Color.white.cornerRadius(8))
                    }

                    if dataController.gameState == .betting {
                        CoinDeck()
                            .padding(.vertical, 32)
                    } else {
                        GameActions()
                            .padding(.vertical, 32)
                    }
                }
            }
            .navigationTitle("Blackjack in SwiftUI")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
