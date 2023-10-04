//
//  EatDetails.swift
//  Gymestry
//
//  Created by Владислава on 19.09.23.
//

import Foundation
import SnapKit
import UIKit

class EatDetails: UIViewController {
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.isUserInteractionEnabled = true
        return label
    }()
    lazy var infoText: UITextView = {
        let label = UITextView()
        label.textColor = .black
        label.isUserInteractionEnabled = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        makeConstraints()
    }
    private func makeLayout() {
        view.backgroundColor = .white
        view.addSubview(image)
        view.addSubview(nameLabel)
        view.addSubview(infoText)
    }
    private func makeConstraints() {
        image.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(60)
        }
        nameLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(image.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        infoText.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-100)
        }
    }
    func set(eat: SporteatModel) {
        self.title = eat.title
        self.nameLabel.text = eat.title
        self.infoText.text = eat.info
    }
}

