//
//  ContentView.swift
//  BlackJack
//
//  Created by Austin Evans on 4/13/21.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var gameController: GameController
    @EnvironmentObject var strategyController: StrategyController

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }

    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()

            VStack {
                TitleView("Speed Blackjack")

                MoneyBox(amount: 2500)

                DealerCardStack()
                PlayerCardStacks()

                Spacer()

                if gameController.gameState == .betting {
                    CoinDeck()
                        .padding(.vertical, 32)
                } else {
                    hints
                    outcomeButtons
                    GameActions()
                        .padding(.bottom, 32)
                }
            }

            if gameController.showDirections {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        gameController.showDirections.toggle()
                    }

                InformationView()
            }

            if gameController.showSettings {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        gameController.showSettings.toggle()
                    }

                SettingsView()
            }
        }
    }

    var outcomeText: String {
        if case .outcome(let outcome) = gameController.gameState {
            return outcome.description
        }
        return "-"
    }

    var outcomeButtons: some View {
        Group {
            Text(outcomeText)
                .foregroundColor(.white)
                .bold()
                .fixedSize(horizontal: false, vertical: true)

            HStack {
                Button(action: {
                    gameController.change(to: .betting)
                }, label: {
                    Text("Rebet")
                        .bold()
                })
                .frame(minWidth: 100)
                .padding()
                .background(Color.white.cornerRadius(8))

                Button(action: {
                    gameController.reset()
                    gameController.change(to: .playerTurn)
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

    var hintText: String {
        let hint = strategyController.generateHint(
            playerCards: gameController.playerCards,
            dealerCards: gameController.dealerCards
        )

        let word: String
        switch hint {
        case "S":
            word = "stand"
        case "D":
            word = "double"
        case "P":
            word = "split"
        case "H":
            word = "hit"
        default:
            return ""
        }

        return "Hint: \(word.capitalized)"
    }

    var hints: some View {
        Group {
            if strategyController.showHint {
                Text(hintText)
            } else {
                EmptyView()
            }
        }
        .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
