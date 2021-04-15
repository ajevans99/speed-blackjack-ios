//
//  GameAction.swift
//  SpeedBlackjack
//
//  Created by Austin Evans on 4/15/21.
//

import SwiftUI

struct GameAction: View {
    static let size: CGFloat = 75

    let actionType: GameActionType

    let onTap: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Image(actionType.rawValue)
                .resizable()
                .frame(width: Self.size, height: Self.size)
            Text(actionType.name)
                .bold()
                .foregroundColor(.white)
        }
        .onTapGesture(perform: onTap)
    }
}

struct GameAction_Previews: PreviewProvider {
    static var previews: some View {
        GameAction(actionType: .hit, onTap: {})
    }
}
