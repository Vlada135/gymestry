//
//  Settings.swift
//  Gymestry
//
//  Created by Владислава on 12.11.23.
//

import SnapKit
import UIKit

enum Settings {
    case password
    case help
    case notifications
    case feedback
    case logout
    
    
    var title: String {
        switch self {
        case .password:         return "Конфиденциальность"
        case .help:             return "Помощь"
        case .notifications:    return "Уведомления"
        case .feedback:         return "Обратная связь"
        case .logout:           return "Выйти из аккаунта"
        }
    }
    var image: UIImage? {
        switch self {
        case .password:       return UIImage(systemName: "lock")
        case .help:           return UIImage(systemName: "questionmark.circle")
        case .notifications:  return UIImage(systemName: "bell")
        case .feedback:       return UIImage(systemName: "envelope")
        case .logout:         return UIImage(systemName: "rectangle.portrait.and.arrow.right")
        }
    }
}
