//
//  ChartItem.swift
//  SpeedBlackjack
//
//  Created by Austin Evans on 4/16/21.
//

import SwiftUI

struct ChartItem: View {
    let text: String
    let isHeader: Bool

    init(_ text: String, isHeader: Bool = false) {
        self.text = text
        self.isHeader = isHeader
    }

    var color: Color {
        guard !isHeader else {
            return .green
        }
        switch text {
        case "H":
            return .blue
        case "D":
            return .orange
        case "P":
            return .red
        default:
            return .gray
        }
    }

    var body: some View {
        Text(text)
            .fontWeight(isHeader ? .bold : .none)
            .foregroundColor(.white)
            .frame(width: 27, height: 27)
            .background(Circle().fill(color))
            .shadow(radius: 4)
    }
}

struct ChartItem_Previews: PreviewProvider {
    static var previews: some View {
        ChartItem("S")
    }
}
