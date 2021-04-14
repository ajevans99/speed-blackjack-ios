//
//  ContentView.swift
//  BlackJack
//
//  Created by Austin Evans on 4/13/21.
//

import SwiftUI

struct ContentView: View {

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
                    CardStack(cards: [.showing(.init()), .showing(.init())])
                    Spacer()
                    CardStack()
                    GameActions()
                        .padding(.vertical, 32)
                    CoinDeck()
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
