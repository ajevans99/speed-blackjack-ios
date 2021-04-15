//
//  MoneyBox.swift
//  BlackJack
//
//  Created by Austin Evans on 4/13/21.
//

import SwiftUI

struct MoneyBox: View {
    @EnvironmentObject var dataController: DataController

    let amount: Int

    var body: some View {
        GeometryReader { geo in
            ZStack {
                HStack {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(LinearGradient(
                            gradient: .init(colors: [Color("purple-3"), Color("background")]),
                            startPoint: .init(x: 0, y: 0.5),
                            endPoint: .init(x: 1, y: 0.5)
                          ))
                        .frame(width: 200, height: geo.size.height - 20)
                        .padding(.leading, 32)
                    Spacer()
                }

                HStack {
                    Image("coin")
                        .resizable()
                        .frame(width: 50, height: 50)
                    Text("$\(dataController.balance)")
                        .font(.system(size: geo.size.height - 25))
                        .bold()
                        .foregroundColor(.white)
                        .padding(.leading, -8)
                        .transition(.scale(scale: 20))
                    Spacer()
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.orange)
                        .background(Color.white.cornerRadius(25))
                        .accessibility(addTraits: .isButton)
                        .onTapGesture {
                            dataController.reset()
                            dataController.change(to: .betting)
                            dataController.balance = 2500
                            dataController.bettingAmount = 50
                        }
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
