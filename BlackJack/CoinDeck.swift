//
//  CoinDeck.swift
//  BlackJack
//
//  Created by Austin Evans on 4/13/21.
//

import SwiftUI

struct Coin: View {
    static let size: CGFloat = 90

    let amount: Int

    var body: some View {
        Image("coin-\(amount)")
            .resizable()
            .frame(width: Self.size, height: Self.size)
    }
}

struct CoinDeck: View {
    var body: some View {
        HStack {
            Coin(amount: 500)
            Coin(amount: 100)
            Coin(amount: 50)
            Coin(amount: 10)
        }
    }
}

struct CoinDeck_Previews: PreviewProvider {
    static var previews: some View {
        CoinDeck()
            .background(Color.blue)
    }
}
