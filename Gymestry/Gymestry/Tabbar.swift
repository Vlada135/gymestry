//
//  Tabbar.swift
//  Gymestry
//
//  Created by Владислава on 11.09.23.
//

import Foundation
import UIKit

class TabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }
    
    func setupControllers() {
        var controllers: [UIViewController] = []
        let _: [UIImage?] = [
            .init(systemName: "calendar"),
            .init(systemName: "book"),
            .init(systemName: "person"),
            .init(systemName: "dumbbell")
        ]
        
        let profileVC1 = ProfileController()
        controllers.append(UINavigationController(rootViewController: profileVC1))
        profileVC1.tabBarItem = .init(title: "Профиль", image: .init(systemName: "person"), tag: 0)
        
        let profileVC2 = ProgramController()
        controllers.append(UINavigationController(rootViewController: profileVC2))
        profileVC2.tabBarItem = .init(title: "Программа", image: .init(systemName: "dumbbell"), tag: 0)
        
        let profileVC3 = CalendarController()
        controllers.append(UINavigationController(rootViewController: profileVC3))
        profileVC3.tabBarItem = .init(title: "Календарь", image: .init(systemName: "calendar"), tag: 0)
        
        let profileVC4 = DirectoryController()
        controllers.append(UINavigationController(rootViewController: profileVC4))
        profileVC4.tabBarItem = .init(title: "Cправочник", image: .init(systemName: "book"), tag: 0)
        
        self.viewControllers = controllers
    }
}
