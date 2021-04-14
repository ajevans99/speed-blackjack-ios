//
//  CoinView.swift
//  BlackJack
//
//  Created by Austin Evans on 4/13/21.
//

import SwiftUI

struct CardView: View {
    let card: CardState

    var body: some View {
        GeometryReader { geo in
            RoundedRectangle(cornerRadius: geo.size.height / 8)
                .fill(Color.white)
                .aspectRatio(1/1.4, contentMode: .fit)
                .overlay(
                    overlay(geo: geo)
                )
                .shadow(radius: 10)
        }
    }

    @ViewBuilder func overlay(geo: GeometryProxy) -> some View {
        switch card {
        case .hidden:
            Image("card-back")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geo.size.width, height: geo.size.height)
        case .showing(let card):
            HStack {
                VStack {
                    Text(card.value.display)
                    Image(systemName: card.suit.imageName)
                    Spacer()
                }
                .padding(10)
                Spacer()
            }
            .font(.system(size: geo.size.height / 5))
            .foregroundColor(card.suit.color)
        }
    }
}

struct CoinView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: .random)
            .frame(width: 100, height: 100)
            .background(Color.black)
    }
}
