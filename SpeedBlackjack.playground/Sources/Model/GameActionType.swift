//
//  GameActionType.swift
//  SpeedBlackjack
//
//  Created by Austin Evans on 4/15/21.
//

import Foundation

enum GameActionType: String {
    case double
    case split
    case hit
    case stand

    var name: String {
        return rawValue.capitalized
    }
}
