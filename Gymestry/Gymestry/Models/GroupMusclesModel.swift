//
//  GroupMusclesModel.swift
//  Gymestry
//
//  Created by Владислава on 17.09.23.
//

import SnapKit
import UIKit

enum GroupMusclesModel {
    case breast
    case back
    case legs
    case glutes
    case deltas
    case biceps
    case triceps
    case forearm
    case abs
    
    var title: String {
        switch self {
        case .breast:    return "Грудь"
        case .back:      return "Спина"
        case .legs:      return "Ноги"
        case .glutes:    return "Ягодицы"
        case .deltas:    return "Дельты"
        case .biceps:    return "Бицепс"
        case .triceps:   return "Трицепс"
        case .forearm:   return "Предплечье"
        case .abs:       return "Пресс"
        }
    }
    var image: UIImage? {
        switch self {
        case .breast:       return UIImage(named: "breast")
        case .back:         return UIImage(named: "back")
        case .legs:         return UIImage(named: "legs")
        case .glutes:       return UIImage(named: "glutes")
        case .deltas:       return UIImage(named: "deltas")
        case .biceps:       return UIImage(named: "biceps")
        case .triceps:      return UIImage(named: "triceps")
        case .forearm:      return UIImage(named: "forearm")
        case .abs:          return UIImage(named: "abs")
        }
    }
    var exercises: [String] {
        switch self {
        case .breast:    return ["Тяга верхнего блока", "Тяга нижнего блока"]
        case .back:      return ["Спина"]
        case .legs:      return ["Приседания", "Жим ногами"]
        case .glutes:    return ["Ягодицы"]
        case .deltas:    return ["Дельты"]
        case .biceps:    return ["Бицепс"]
        case .triceps:   return ["Трицепс"]
        case .forearm:   return ["Предплечье"]
        case .abs:       return ["Пресс"]
        }
    }
}

class Exercises {
    
    var name: String
    var type: GroupMusclesModel
    var description: String
    
    init(name: String, type: GroupMusclesModel, description: String) {
        self.name = name
        self.type = type
        self.description = description
    }
}

var testExercises: [Exercises] = [
    .init(name: "Жим ногами", type: .legs, description: "Приседай"),
    .init(name: "Тяга верхнего блока", type: .breast, description: "Тяни")
]

