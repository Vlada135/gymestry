//
//  DirectoryModel.swift
//  Gymestry
//
//  Created by Владислава on 12.09.23.
//
import SnapKit
import UIKit

enum Directory {
    case exercises
    case sporteat
    case info
    case calculator
    
    var title: String {
        switch self {
        case .exercises:     return "Упражнения"
        case .sporteat:      return "Спортивное питание"
        case .info:          return "Энциклопедия"
        case .calculator:    return "Калькулятор калорий"
        }
    }
    var image: UIImage? {
        switch self {
        case .exercises:        return UIImage(named: "exercises")
        case .sporteat:         return UIImage(named: "sporteat")
        case .info:             return UIImage(named: "info")
        case .calculator:       return UIImage(named: "calculator")
        }
    }
}
