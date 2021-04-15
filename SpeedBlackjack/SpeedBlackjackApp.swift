//
//  SpeedBlackjackApp.swift
//  BlackJack
//
//  Created by Austin Evans on 4/13/21.
//

import SwiftUI

@main
struct SpeedBlackjackApp: App {
    @StateObject var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataController)
        }
    }
}
