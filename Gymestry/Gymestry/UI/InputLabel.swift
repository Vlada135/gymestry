//
//  InputLabel.swift
//  Gymestry
//
//  Created by Владислава on 6.10.23.
//
import UIKit

class InputLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        self.isUserInteractionEnabled = true
        self.textAlignment = .center
        self.font = .systemFont(ofSize: 17, weight: .bold)
        self.text = ""
    }
    
}

