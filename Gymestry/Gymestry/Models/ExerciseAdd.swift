//
//  ExerciseAdd.swift
//  Gymestry
//
//  Created by Владислава on 22.11.23.
//

import UIKit

struct ExerciseAdd: Editable {
    var id: String?
    let name: String
    let exerciseID: String
    let exerciseImage: String?
    
    var asDict: [String: Any] {
        var dict = [String: Any]()
        dict["id"] = id
        dict["name"] = name
        dict["exerciseID"] = exerciseID
        dict["exerciseImage"] = exerciseImage
        return dict
    }
    
    init(
        id: String? = nil,
        name: String,
        exerciseID: String,
        exerciseImage: String? = nil
    ) {
        self.id = id
        self.name = name
        self.exerciseID = exerciseID
        self.exerciseImage = exerciseImage
    }
    
    init(key: String, dict: [String: Any]) throws {
        guard
            let name = dict["name"] as? String,
            let exerciseID = dict["exerciseID"] as? String
        else {
            let error = "Parsing contact error"
            print("[Contact parser] \(error)")
            throw error
        }
        self.id = key
        self.name = name
        self.exerciseID = exerciseID
        self.exerciseImage = dict["exerciseImage"] as? String
    }
}
