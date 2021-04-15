//
//  GameActions.swift
//  BlackJack
//
//  Created by Austin Evans on 4/13/21.
//

import SwiftUI

struct GameActions: View {
    @EnvironmentObject var gameController: GameController

    var body: some View {
        HStack {
            GameAction(actionType: .double, onTap: gameController.double)
                .opacity(gameController.doubleable ? 1 : 0.5)
                .disabled(!gameController.doubleable)
            GameAction(actionType: .split, onTap: gameController.split)
                .opacity(gameController.splittable ? 1 : 0.5)
                .disabled(!gameController.splittable)
            GameAction(actionType: .hit, onTap: gameController.hit)
                .opacity(gameController.actionsEnabled ? 1 : 0.5)
            GameAction(actionType: .stand, onTap: gameController.stand)
                .opacity(gameController.actionsEnabled ? 1 : 0.5)
        }
        .disabled(!gameController.actionsEnabled)
        .animation(.easeInOut)
    }
}

struct GameActions_Previews: PreviewProvider {
    static var previews: some View {
        GameActions()
    }
}
