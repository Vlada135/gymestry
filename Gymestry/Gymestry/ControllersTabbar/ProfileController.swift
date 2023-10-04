//
//  ProfileController.swift
//  Gymestry
//
//  Created by Владислава on 1.10.23.
//

import Foundation
import UIKit
import SnapKit

class ProfileController: UIViewController {
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
    }
    private func makeLayout() {
        view.backgroundColor = .white
        title = "Профиль"
    }

}
