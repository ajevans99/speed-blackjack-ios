//
//  StrategyController.swift
//  SpeedBlackjack
//
//  Created by Austin Evans on 4/16/21.
//

import Foundation
import Combine

class StrategyController: ObservableObject {
    typealias Data = [String: [String: String]]

    private var jsonHard: JSON?
    private var jsonSoft: JSON?
    private var jsonSplit: JSON?

    var hardHands: Data {
        guard let jsonHard = jsonHard else { return .init() }
        return createDictionaryOfDictionaries(from: jsonHard)
    }

    var softHands: Data {
        guard let jsonSoft = jsonSoft else { return .init() }
        return createDictionaryOfDictionaries(from: jsonSoft)
    }

    var splitHands: Data {
        guard let jsonSplit = jsonSplit else { return .init() }
        return createDictionaryOfDictionaries(from: jsonSplit)
    }

    init() { load() }

    private func loadFromPath(forResource resource: String) -> JSON? {
        if let filepath = Bundle.main.path(forResource: resource, ofType: "json"),
           let content = try? String(contentsOfFile: filepath) {
            return try? JSON(string: content)
        }
        return nil
    }

    func load() {
        jsonHard = loadFromPath(forResource: "BasicStrategy_Hard")
        jsonSoft = loadFromPath(forResource: "BasicStrategy_Soft")
        jsonSplit = loadFromPath(forResource: "BasicStrategy_Split")
    }

    func release() {
        jsonHard = nil
        jsonSoft = nil
        jsonSplit = nil
    }

    private func createDictionaryOfDictionaries(from json: JSON) -> Data {
        json.dictionary.mapValues { $0.dictionary.mapValues { $0.string } }
    }
}
