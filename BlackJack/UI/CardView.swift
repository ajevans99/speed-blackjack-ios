//
//  CoinView.swift
//  BlackJack
//
//  Created by Austin Evans on 4/13/21.
//

import SwiftUI

struct FlipView<Front: View, Back: View>: View {
    var isFlipped: Bool
    var front: () -> Front
    var back: () -> Back

    init(isFlipped: Bool = false, @ViewBuilder front: @escaping () -> Front, @ViewBuilder back: @escaping () -> Back) {
        self.isFlipped = isFlipped
        self.front = front
        self.back = back
    }

    var body: some View {
        ZStack {
            front()
                .rotation3DEffect(.degrees(isFlipped == true ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                .opacity(isFlipped == true ? 0 : 1)
                .accessibility(hidden: isFlipped == true)

            back()
                .rotation3DEffect(.degrees(isFlipped == true ? 0 : -180), axis: (x: 0, y: 1, z: 0))
                .opacity(isFlipped == true ? 1 : 0)
                .accessibility(hidden: isFlipped == false)
        }
    }
}

struct CardView: View {
    @Binding var cardState: CardState

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
        FlipView(isFlipped: cardState.isHidden) {
            HStack(alignment: .top) {
                VStack {
                    Text(cardState.card.value.display)
                    Image(systemName: cardState.card.suit.imageName)
                    Spacer()
                }
                .transition(.opacity)
                .animation(.easeInOut)
                .padding(10)
                Spacer()
            }
            .font(.system(size: geo.size.height / 5))
            .foregroundColor(cardState.card.suit.color)
        } back: {
            Image("card-back")
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .animation(.linear)
    }
}

//struct CoinView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(cardState: .init(isHidden: false))
//            .frame(width: 100, height: 100)
//            .background(Color.black)
//    }
//}
