//
//  SpeedBlackjackApp.swift
//  BlackJack
//
//  Created by Austin Evans on 4/13/21.
//

import SwiftUI

@main
struct SpeedBlackjackApp: App {
    @StateObject var gameController = GameController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameController)
        }
    }
}
