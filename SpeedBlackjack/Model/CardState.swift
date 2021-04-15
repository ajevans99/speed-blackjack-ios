//
//  CardState.swift
//  BlackJack
//
//  Created by Austin Evans on 4/14/21.
//

import Foundation

class CardState: ObservableObject, Hashable, Equatable {
    let card: Card

    @Published var isHidden: Bool

    init(card: Card = Card(), isHidden: Bool = true) {
        self.card = card
        self.isHidden = isHidden
    }

    static func == (lhs: CardState, rhs: CardState) -> Bool {
        lhs.card == rhs.card && lhs.isHidden == rhs.isHidden
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(card)
        hasher.combine(isHidden)
    }
}
