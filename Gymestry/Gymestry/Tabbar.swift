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
            .init(systemName: "pencil"),
            .init(systemName: "book")
        ]
        
        let profileVC = DirectoryController()
        controllers.append(UINavigationController(rootViewController: profileVC))
        profileVC.tabBarItem = .init(title: "Cправочник", image: .init(systemName: "book"), tag: 0)

//        let profileVC2 = HistoryController()
//        controllers.append(UINavigationController(rootViewController: profileVC2))
//        profileVC2.tabBarItem = .init(title: "История", image: .init(systemName: "pencil"), tag: 0)
//
        self.viewControllers = controllers
    }
}
