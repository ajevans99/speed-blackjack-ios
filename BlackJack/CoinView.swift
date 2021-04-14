//
//  CoinView.swift
//  BlackJack
//
//  Created by Austin Evans on 4/13/21.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        GeometryReader { geo in
            RoundedRectangle(cornerRadius: geo.size.height / 8)
                .stroke(Color.black, lineWidth: 5)
                .aspectRatio(1/1.4, contentMode: .fit)
                .overlay(
                    HStack {
                        VStack {
                            Text("A")
                            Image(systemName: "suit.spade.fill")
                            Spacer()
                        }
                        .padding()
                        Spacer()
                    }
                    .font(.system(size: geo.size.height / 5))
                )
        }
    }
}

struct CoinView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
            .frame(width: 100, height: 100)
    }
}
