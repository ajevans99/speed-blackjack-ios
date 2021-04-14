//
//  GameActions.swift
//  BlackJack
//
//  Created by Austin Evans on 4/13/21.
//

import SwiftUI

enum GameActionType: String {
    case double
    case split
    case hit
    case stand

    var name: String {
        return rawValue.capitalized
    }
}

struct GameAction: View {
    static let size: CGFloat = 75

    let actionType: GameActionType

    var body: some View {
        VStack(spacing: 0) {
            Image(actionType.rawValue)
                .resizable()
                .frame(width: Self.size, height: Self.size)
            Text(actionType.name)
                .bold()
                .foregroundColor(.white)
        }
    }
}

struct GameActions: View {
    var body: some View {
        HStack {
            GameAction(actionType: .double)
            GameAction(actionType: .split)
            GameAction(actionType: .hit)
            GameAction(actionType: .stand)
        }
    }
}

struct GameActions_Previews: PreviewProvider {
    static var previews: some View {
        GameActions()
    }
}
