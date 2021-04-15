//
//  TitleView.swift
//  SpeedBlackjack
//
//  Created by Austin Evans on 4/15/21.
//

import SwiftUI

struct TitleView: View {
    let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        HStack {
            Text(text)
                .bold()
                .font(.largeTitle)
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.top, 64)
        .padding(.horizontal)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView("Speed Blackjack")
    }
}
