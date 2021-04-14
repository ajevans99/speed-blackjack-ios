//
//  MoneyBox.swift
//  BlackJack
//
//  Created by Austin Evans on 4/13/21.
//

import SwiftUI

struct MoneyBox: View {
    let amount: Int

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.purple
                    .frame(width: geo.size.width - 30, height: geo.size.height - 20)
                HStack {
                    Image("coin")
                        .resizable()
                        .frame(width: 50, height: 50)
                    Text("$\(amount)")
                        .font(.system(size: geo.size.height - 25))
                        .bold()
                        .foregroundColor(.white)
                        .padding(.leading, -8)
                    Spacer()
                    Image(systemName: "plus.square.fill")
                        .resizable()
                        .frame(width: geo.size.height - 15, height: geo.size.height - 15)
                        .foregroundColor(.orange)
                        .background(Color.white.cornerRadius(8))
                }
            }
        }
    }
}

struct MoneyBox_Previews: PreviewProvider {
    static var previews: some View {
        MoneyBox(amount: 50)
            .frame(width: 200, height: 50, alignment: .center)
            .background(Color.black)
    }
}
