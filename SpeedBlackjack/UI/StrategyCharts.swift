//
//  StategyCharts.swift
//  SpeedBlackjack
//
//  Created by Austin Evans on 4/15/21.
//

import SwiftUI

struct StrategyCharts: View {
    @EnvironmentObject var strategyController: StrategyController

    var body: some View {
        VStack {
            Text("Basic Strategy")
                .bold()
                .font(.title3)
                .foregroundColor(.white)
                .padding()

            Text("Hard Hands")
                .foregroundColor(.white)
                .font(.headline)
        
            StrategyChart(data: strategyController.hardHands)

            Text("Soft Hands")
                .foregroundColor(.white)
                .font(.headline)

            StrategyChart(data: strategyController.softHands)

            Text("Pair Hands")
                .foregroundColor(.white)
                .font(.headline)

            StrategyChart(data: strategyController.splitHands)
        }
    }
}

struct StategyCharts_Previews: PreviewProvider {
    static var previews: some View {
        StrategyCharts()
    }
}
