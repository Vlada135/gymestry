//
//  Weights.swift
//  Gymestry
//
//  Created by Владислава on 26.11.23.
//

import Foundation

struct Weights: Editable {
    var id: String?
    let weight: Double
    let date: Date
    
    var asDict: [String: Any] {
        var dict = [String: Any]()
        dict["weight"] = weight
        dict["date"] = date.timeIntervalSince1970
        return dict
    }
    
    init(
        id: String? = nil,
        weight: Double,
        date: Date
    ) {
        self.id = id
        self.weight = weight
        self.date = date
    }
    
    init(key: String, dict: [String: Any]) throws {
        guard let weight = dict["weight"] as? Double,
              let date = dict["date"] as? Double
        else {
            let error = "Parsing contact error"
            print("[Contact parser] \(error)")
            throw error
        }
        self.id = key
        self.weight = weight
        self.date = Date(timeIntervalSince1970: date)
    }
}
