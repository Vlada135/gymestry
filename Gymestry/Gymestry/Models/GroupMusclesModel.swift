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
//    var image: UIImage? {
//        switch self {
//        case .breast:       return UIImage(named: "")
//        case .back:         return UIImage(named: "")
//        case .legs:         return UIImage(named: "")
//        case .glutes:
//            <#code#>
//        case .deltas:
//            <#code#>
//        case .biceps:
//            <#code#>
//        case .triceps:
//            <#code#>
//        case .forearm:
//            <#code#>
//        case .abs:
//            <#code#>
//        }
//    }
}
