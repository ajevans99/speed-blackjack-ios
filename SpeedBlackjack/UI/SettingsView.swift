//
//  SettingsView.swift
//  SpeedBlackjack
//
//  Created by Austin Evans on 4/15/21.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var gameController: GameController

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color("background"))

            ScrollView {
                VStack(alignment: .center) {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                            .padding([.top, .trailing])
                            .accessibility(addTraits: .isButton)
                            .onTapGesture {
                                gameController.showSettings.toggle()
                            }
                    }
                    Image("info-app-icon")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .shadow(radius: 16)
                        .cornerRadius(24)
                        .padding()

                    Text("Settings")
                        .bold()
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                        .padding()
                }

                StrategyCharts()
            }
        }
        .padding(.vertical, 128)
        .padding(.horizontal, 32)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
