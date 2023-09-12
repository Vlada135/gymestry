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
    case farma
    
    
    var title: String {
        switch self {
        case .exercises:     return "Упражнения"
        case .sporteat:      return "Спортивное питание"
        case .farma:         return "Фармакология"
        }
    }
    
//    var image: UIImage? {
//        switch self {
//        case .profile:          return UIImage(systemName: "person.fill")
//        case .payments:         return UIImage(systemName: "bitcoinsign.circle")
//        case .notification:     return UIImage(systemName: "bell.fill")
//        case .reminders:        return UIImage(systemName: "clock")
//        case .logout:           return UIImage(systemName: "door.left.hand.open")
//        }
//    }
}
