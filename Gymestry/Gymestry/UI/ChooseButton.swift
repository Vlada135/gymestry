//
//  ChooseButton.swift
//  Gymestry
//
//  Created by Владислава on 12.10.23.
//

import UIKit

class ChooseButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.alpha = 0.7
        self.tintColor = .black
    }
    
}
