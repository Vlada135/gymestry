//
//  EncyclopediaDetails.swift
//  Gymestry
//
//  Created by Владислава on 24.11.23.
//

import Foundation
import SnapKit
import UIKit

class EncyclopediaDetails: UIViewController {
    
    private lazy var mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var gradientView: UIView = {
        let view = Gradient()
        view.startColor = UIColor.black
        view.endColor = nil
        view.horizontalMode = true
        view.alpha = 1
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
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
        title = "Энциклопедия"
        view.backgroundColor = .white
        view.addSubview(mainView)
        mainView.addSubview(image)
        mainView.addSubview(gradientView)
        view.addSubview(nameLabel)
        view.addSubview(infoText)
    }
    
    private func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(25)
            make.height.equalTo(150)
        }
        image.snp.makeConstraints{ make in
            make.edges.equalTo(mainView)
        }
        gradientView.snp.makeConstraints{ make in
            make.edges.equalTo(mainView)
        }
        nameLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(mainView.snp.bottom).offset(25)
        }
        infoText.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-100)
        }
    }
    
    func set(encyclopedia: Encyclopedia) {
        self.nameLabel.text = encyclopedia.title
        self.infoText.text = encyclopedia.description?.replacingOccurrences(of: "[br]", with: "\n\n")
        
        DispatchQueue.global().async { [weak self] in
            guard let self,
                  let url = URL(string: encyclopedia.encyclopediaImage),
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
