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
        self.configuration = .filled()
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.layer.cornerRadius = 12
        self.clipsToBounds = false
        self.alpha = 0.7
        self.tintColor = .black
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 5
    }
    
}
