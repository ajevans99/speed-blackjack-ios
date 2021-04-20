//
//  JSON.swift
//  SpeedBlackjack
//
//  Created by Austin Evans on 4/16/21.
//

import Foundation

/// Adapted from Hacking with Swift+ `Parsing difficult JSON`
/// https://www.hackingwithswift.com/plus/working-with-data/parsing-difficult-json
@dynamicMemberLookup
struct JSON: RandomAccessCollection {
    var value: Any?
    var startIndex: Int { array.startIndex }
    var endIndex: Int { array.endIndex }


    init(string: String) throws {
        let data = Data(string.utf8)
        value = try JSONSerialization.jsonObject(with: data)
    }

    init(value: Any?) {
        self.value = value
    }

    var optionalBool: Bool? {
        value as? Bool
    }

    var optionalDouble: Double? {
        value as? Double
    }

    var optionalInt: Int? {
        value as? Int
    }

    var optionalString: String? {
        value as? String
    }

    var bool: Bool {
        optionalBool ?? false
    }

    var double: Double {
        optionalDouble ?? 0
    }

    var int: Int {
        optionalInt ?? 0
    }

    var string: String {
        optionalString ?? ""
    }

    var optionalArray: [JSON]? {
        let converted = value as? [Any]
        return converted?.map(JSON.init)
    }

    var optionalDictionary: [String: JSON]? {
        let converted = value as? [String: Any]
        return converted?.mapValues(JSON.init)
    }

    var array: [JSON] {
        optionalArray ?? []
    }

    var dictionary: [String: JSON] {
        optionalDictionary ?? [:]
    }

    subscript(index: Int) -> JSON {
        optionalArray?[index] ?? JSON(value: nil)
    }

    subscript(key: String) -> JSON {
        optionalDictionary?[key] ?? JSON(value: nil)
    }

    subscript(dynamicMember key: String) -> JSON {
        optionalDictionary?[key] ?? JSON(value: nil)
    }
}
