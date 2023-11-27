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
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var infoText: UITextView = {
        let view = UITextView()
        view.textColor = .black
        view.isEditable = false
        view.font = .systemFont(ofSize: 15, weight: .thin)
        view.isUserInteractionEnabled = true
        return view
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
            make.top.equalTo(view.safeAreaLayoutGuide).offset(25)
            make.height.equalTo(200)
        }
        nameLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(image.snp.bottom).offset(20)
            make.height.equalTo(20)
        }
        infoText.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-100)
        }
    }
    
    func set(eat: Sporteat) {
        self.title = eat.sporteat
        self.nameLabel.text = eat.sporteat
        self.infoText.text = eat.description?.replacingOccurrences(of: "[br]", with: "\n\n")
        
        DispatchQueue.global().async { [weak self] in
            guard let self,
                  let url = URL(string: eat.sporteatImage),
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else { return }
            print("1")
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                print("2")
                self.image.image = image
            }
        }
    }
}

