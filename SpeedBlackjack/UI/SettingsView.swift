//
//  SettingsView.swift
//  SpeedBlackjack
//
//  Created by Austin Evans on 4/15/21.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var gameController: GameController
    @EnvironmentObject var strategyController: StrategyController

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
                            .frame(width: 30, height: 30)
                            .padding([.top, .trailing])
                            .accessibility(addTraits: .isButton)
                            .onTapGesture {
                                gameController.showSettings.toggle()
                            }
                    }

                    Text("Basic Strategy")
                        .bold()
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                        .padding()

                    Toggle(isOn: $strategyController.showHint) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Show Hints")
                                .bold()
                            Text("Display basic strategy hints to learn to optimize chance of win.")
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.caption)
                        }
                    }
                    .padding()

                    key
                        .padding(.horizontal)

                    StrategyCharts()
                }
            }
        }
        .foregroundColor(.white)
        .padding(.vertical, 128)
        .padding(.horizontal, 32)
    }

    var key: some View {
        VStack(spacing: 8) {
            Text("Key")
                .font(.headline)

            HStack {
                Text("Hit")
                Spacer()
                ChartItem("H")
            }
            HStack {
                Text("Stand")
                Spacer()
                ChartItem("S")
            }
            HStack {
                Text("Double")
                Spacer()
                ChartItem("D")
            }
            HStack {
                Text("Split")
                Spacer()
                ChartItem("P")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
