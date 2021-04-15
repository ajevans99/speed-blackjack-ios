//
//  Binding+Equatable.swift
//  BlackJack
//
//  Created by Austin Evans on 4/15/21.
//

import SwiftUI

/// I'm shocked this worked, but clearing `splitCards` in `gameController`
/// caused a crash before in the ForLoop for `CardStack`
/// https://stackoverflow.com/a/64760104
extension Binding where Value: Equatable {
    static func proxy(_ source: Binding<Value>) -> Binding<Value> {
            self.init(
                get: { source.wrappedValue },
                set: { source.wrappedValue = $0 }
            )
    }
}
