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

struct GameActions: View {
    @EnvironmentObject var dataController: DataController

    var body: some View {
        HStack {
            GameAction(actionType: .double, onTap: dataController.double)
            GameAction(actionType: .split, onTap: dataController.split)
                .disabled(!dataController.splittable)
            GameAction(actionType: .hit, onTap: dataController.hit)
            GameAction(actionType: .stand, onTap: dataController.stand)
        }
    }
}

struct GameActions_Previews: PreviewProvider {
    static var previews: some View {
        GameActions()
    }
}
