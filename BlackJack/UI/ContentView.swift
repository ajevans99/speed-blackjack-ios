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
                    MoneyBox(amount: 2500)
                        .frame(height: 50)
                        .padding()

                    CardStack(cards: $dataController.dealerCards,
                              didBust: dataController.dealerBust)
                        .padding(.bottom, 32)
                    CardStack(cards: $dataController.playerCards,
                              didBust: dataController.playerBust)
                        .padding(.bottom, 32)
                    BetAmountView()

                    Spacer()

                    if dataController.gameState == .betting {
                        CoinDeck()
                            .padding(.vertical, 32)
                    } else {
                        outcomeButtons
                        GameActions()
                            .padding(.bottom, 32)
                    }
                }
            }
            .navigationTitle("Blackjack in SwiftUI")
        }
    }

    var outcomeText: String {
        if case .outcome(let outcome) = dataController.gameState {
            return outcome.description
        }
        return "-"
    }

    var outcomeButtons: some View {
        Group {
            Text(outcomeText)
                .foregroundColor(.white)
                .bold()
            HStack {
                Button(action: {
                    dataController.change(to: .betting)
                }, label: {
                    Text("Rebet")
                        .bold()
                })
                .frame(minWidth: 100)
                .padding()
                .background(Color.white.cornerRadius(8))

                Button(action: {
                    dataController.reset()
                    dataController.change(to: .playerTurn)
                }, label: {
                    Text("Rebet and deal")
                        .bold()
                })
                .frame(minWidth: 100)
                .padding()
                .background(Color.white.cornerRadius(8))
            }
        }
        .opacity(outcomeText == "-" ? 0 : 1)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
