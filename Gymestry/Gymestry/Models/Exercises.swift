//
//  Exercises.swift
//  Gymestry
//
//  Created by Владислава on 6.11.23.
//

import UIKit

struct Exercises: Editable {
    var id: String?
    var idGroup: String?
    let exercise: String
    let instruction: String?
    let exerciseGIF: String?
    let exerciseImage: String?
    let weightSelect: Bool
    let numberSelect: Bool
    let durationSelect: Bool
    
    var asDict: [String: Any] {
        var dict = [String: Any]()
        dict["exercise"] = exercise
        dict["idGroup"] = idGroup
        dict["instruction"] = instruction
        dict["exerciseGIF"] = exerciseGIF
        dict["weightSelect"] = weightSelect
        dict["numberSelect"] = numberSelect
        dict["durationSelect"] = durationSelect
        dict["exerciseImage"] = exerciseImage
        return dict
    }
    
    init(
        id: String? = nil,
        idGroup: String? = nil,
        exercise: String,
        description: String? = nil,
        exerciseGIF: String? = nil,
        weightSelect: Bool,
        numberSelect: Bool,
        durationSelect: Bool,
        exerciseImage: String? = nil
    ) {
        self.id = id
        self.idGroup = idGroup
        self.exercise = exercise
        self.instruction = description
        self.exerciseGIF = exerciseGIF
        self.weightSelect = weightSelect
        self.numberSelect = numberSelect
        self.durationSelect = durationSelect
        self.exerciseImage = exerciseImage
    }
    
    init(key: String, dict: [String: Any]) throws {
        guard
            let exercise = dict["exercise"] as? String,
            let idGroup = dict["idGroup"] as? String,
            let weightSelect = dict["weightSelect"] as? Bool,
            let numberSelect = dict["numberSelect"] as? Bool,
            let durationSelect = dict["durationSelect"] as? Bool
                
        else {
            let error = "Parsing contact error"
            print("[Contact parser] \(error)")
            throw error
        }
        self.id = key
        self.idGroup = idGroup
        self.exercise = exercise
        self.instruction = dict["instruction"] as? String
        self.weightSelect = weightSelect
        self.numberSelect = numberSelect
        self.durationSelect = durationSelect
        self.exerciseImage = dict["exerciseImage"] as? String
        self.exerciseGIF = dict["exerciseGIF"] as? String
    }
}
