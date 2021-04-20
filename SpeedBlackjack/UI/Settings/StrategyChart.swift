//
//  StrategyChart.swift
//  SpeedBlackjack
//
//  Created by Austin Evans on 4/15/21.
//

import SwiftUI

struct StrategyHeaderRow: View {
    static let values = [" "] + (2...10).map(String.init) + ["A"]

    var columns: [GridItem] = (0..<StrategyHeaderRow.values.count)
        .map { _ in GridItem(.adaptive(minimum: 27)) }


    var body: some View {
        LazyVGrid(columns: columns, spacing: 6) {
            ForEach(Self.values, id: \.self) { value in
                ChartItem(value, isHeader: true)
            }
        }
        .background(
            Color("background")
                .opacity(0.75)
                .scaleEffect(.init(width: 2, height: 1.2))
        )
    }
}

struct StrategyChart: View {
    var data: [String: [String: String]]

    var columns: [GridItem] = (0..<StrategyHeaderRow.values.count)
        .map { _ in GridItem(.adaptive(minimum: 27)) }

    var body: some View {
        LazyVGrid(columns: columns, spacing: 6, pinnedViews: [.sectionHeaders]) {
            Section(header: StrategyHeaderRow()) {
                ForEach(orderedKeys(data), id: \.self) { rowKey in
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
        return dictionary.keys.sorted { (lhs, rhs) -> Bool in
            if let lhs = Int(lhs), let rhs = Int(rhs) {
                return lhs < rhs
            }
            return Int(rhs) == nil
        }
    }
}
