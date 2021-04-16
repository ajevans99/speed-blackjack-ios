//
//  StrategyChart.swift
//  SpeedBlackjack
//
//  Created by Austin Evans on 4/15/21.
//

import SwiftUI

struct StrategyHeaderRow: View {
    let values = [" "] + (2...10).map(String.init) + ["A"]

    var body: some View {
        HStack(spacing: 6) {
            ForEach(values, id: \.self) { value in
                ChartItem(value, isHeader: true)
            }
        }
    }
}

struct StrategyChart: View {
    var data: [String: [String: String]]

    var body: some View {
        VStack(spacing: 6) {
            StrategyHeaderRow()

            ForEach(orderedKeys(data), id: \.self) { rowKey in
                HStack(spacing: 6) {
                    ChartItem(rowKey, isHeader: true)
                    
                    ForEach(orderedKeys(data[rowKey]!), id: \.self) { columnKey in
                        if columnKey == "1" {
                            ChartItem("\(data[rowKey]![columnKey]!)", isHeader: true)
                        } else {
                            ChartItem("\(data[rowKey]![columnKey]!)")
                        }
                    }
                }
            }
        }
        .padding()
    }

    func orderedKeys<T>(_ dictionary: [String: T]) -> [String] {
        return dictionary.keys.map { Int($0)! }.sorted().map(String.init)
    }
}
