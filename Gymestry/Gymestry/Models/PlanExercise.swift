//
//  PlanExercise.swift
//  Gymestry
//
//  Created by Владислава on 21.11.23.
//

import UIKit

struct PlanExercise: Editable {
    var id: String?
    let name: String?
    let exercises: [ExerciseAdd]?
  
    
    
    var asDict: [String: Any] {
        var dict = [String: Any]()
        dict["name"] = name
        dict["exercises"] = exercises
        return dict
    }
    
    init(
        id: String? = nil,
        name: String? = nil,
        exercises: [ExerciseAdd]? = nil
    ) {
        self.id = id
        self.name = name
        self.exercises = exercises
    }
    
    init(key: String, dict: [String: Any]) throws {
        self.id = key
        self.name = dict["name"] as? String
        self.exercises = dict["exercises"] as? [ExerciseAdd]
    }
}

