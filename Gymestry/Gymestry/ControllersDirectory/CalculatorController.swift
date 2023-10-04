//
//  CalculatorController.swift
//  Gymestry
//
//  Created by Владислава on 1.10.23.
//

import Foundation
import SnapKit
import UIKit

class CalculatorController: UIViewController {
    
    var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height)
    }
        
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.frame = view.bounds
        scroll.contentSize = contentSize
        return scroll
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.frame.size = contentSize
        return view
    }()
    
    lazy var genderView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .white
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 5
        return view
    }()
    
    lazy var ageView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .white
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 5
        return view
    }()
    
    lazy var heightView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .white
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 5
        return view
    }()
    
    lazy var weightView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .white
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 5
        return view
    }()
    
    lazy var activeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .white
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 5
        return view
    }()
    
    lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.textAlignment = .center
        label.text = "Ваш пол?"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.textAlignment = .center
        label.text = "Ваш возраст?"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.textAlignment = .center
        label.text = "Ваш вес?"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.textAlignment = .center
        label.text = "Ваш рост?"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    lazy var womanImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "woman")
        view.layer.cornerRadius = 50
        return view
    }()
    
    lazy var manImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "man")
        view.layer.cornerRadius = 50
        return view
    }()
    
    private lazy var womanButton: UIButton = {
        let button = UIButton(configuration: .tinted())
        button.setTitle(
            "Женщина",
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(action),
            for: .touchUpInside
        )
        return button
    }()
    private lazy var manButton: UIButton = {
        let button = UIButton(configuration: .tinted())
        button.setTitle(
            "Мужчина",
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(action),
            for: .touchUpInside
        )
        return button
    }()
    
    lazy var ageTextField: UITextField = {
        let text = UITextField()
        text.keyboardType = UIKeyboardType.numberPad
        text.placeholder = "Возраст"
        text.textAlignment = .center
        return text
    }()
    
    lazy var heightTextField: UITextField = {
        let height = UITextField()
        height.keyboardType = UIKeyboardType.numberPad
        height.placeholder = "Рост, см"
        height.textAlignment = .center
        return height
    }()
    
    lazy var weightTextField: UITextField = {
        let weight = UITextField()
        weight.keyboardType = UIKeyboardType.numberPad
        weight.placeholder = "Вес, кг"
        weight.textAlignment = .center
        return weight
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(
            "Рассчитать",
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(action),
            for: .touchUpInside
        )
        return button
    }()
    
    lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        makeConstraints()
    }
    
    private func makeLayout() {
        view.backgroundColor = .white
        title = "Калькулятор калорий"
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        
        contentView.addSubview(genderView)
        genderView.addSubview(genderLabel)
        genderView.addSubview(womanImage)
        genderView.addSubview(manImage)
        genderView.addSubview(womanButton)
        genderView.addSubview(manButton)

        contentView.addSubview(ageView)
        ageView.addSubview(ageLabel)
        ageView.addSubview(ageTextField)
        
        contentView.addSubview(heightView)
        heightView.addSubview(heightLabel)
        heightView.addSubview(heightTextField)
        
        contentView.addSubview(weightView)
        weightView.addSubview(weightLabel)
        weightView.addSubview(weightTextField)
        
        contentView.addSubview(activeView)

        
        view.addSubview(actionButton)
        view.addSubview(resultLabel)
    }
    private func makeConstraints() {
     
        genderView.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.centerX.equalToSuperview()
//            make.leading.top.equalTo(view.safeAreaLayoutGuide).offset(20)
//            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
            make.top.equalTo(contentView.snp.top).offset(10)
        }
        
        genderLabel.snp.makeConstraints{ make in
            make.leading.equalTo(genderView.snp.leading).offset(10)
            make.trailing.equalTo(genderView.snp.trailing).offset(-10)
            make.top.equalTo(genderView.snp.top).offset(10)
            make.height.equalTo(30)
        }
        womanImage.snp.makeConstraints{ make in
            make.leading.equalTo(genderView.snp.leading).offset(90)
            make.top.equalTo(genderLabel.snp.bottom).offset(5)
            make.height.width.equalTo(50)
        }
        womanButton.snp.makeConstraints{ make in
            make.top.equalTo(womanImage.snp.bottom).offset(10)
            make.centerX.equalTo(womanImage.snp.centerX)
            make.width.equalTo(120)
            make.bottom.equalTo(genderView.snp.bottom).offset(-10)

        }
        manImage.snp.makeConstraints{ make in
            make.trailing.equalTo(genderView.snp.trailing).offset(-90)
            make.top.equalTo(genderLabel.snp.bottom).offset(5)
            make.height.width.equalTo(50)
        }
        manButton.snp.makeConstraints{ make in
            make.top.equalTo(manImage.snp.bottom).offset(10)
            make.centerX.equalTo(manImage.snp.centerX)
            make.width.equalTo(120)
            make.bottom.equalTo(genderView.snp.bottom).offset(-10)
        }
        
        ageView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
//            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
//            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
            make.top.equalTo(genderView.snp.bottom).offset(10)
        }
        
        ageLabel.snp.makeConstraints{ make in
            make.leading.equalTo(ageView.snp.leading).offset(10)
            make.trailing.equalTo(ageView.snp.trailing).offset(-10)
            make.top.equalTo(ageView.snp.top).offset(10)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
        ageTextField.snp.makeConstraints{ make in
            make.leading.equalTo(ageView.snp.leading).offset(100)
            make.top.equalTo(ageLabel.snp.bottom).offset(5)
            make.width.equalTo(20)
            make.bottom.equalTo(ageView.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
        }
        
        heightView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
//            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
//            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
            make.top.equalTo(ageView.snp.bottom).offset(10)
        }
        
        heightLabel.snp.makeConstraints{ make in
            make.leading.equalTo(heightView.snp.leading).offset(10)
            make.trailing.equalTo(heightView.snp.trailing).offset(-10)
            make.top.equalTo(heightView.snp.top).offset(10)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
        heightTextField.snp.makeConstraints{ make in
            make.leading.equalTo(heightView.snp.leading).offset(100)
            make.top.equalTo(heightLabel.snp.bottom).offset(5)
            make.width.equalTo(20)
            make.bottom.equalTo(heightView.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
        }
        weightView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
//            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
//            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
            make.top.equalTo(heightView.snp.bottom).offset(10)
        }
        
        weightLabel.snp.makeConstraints{ make in
            make.leading.equalTo(weightView.snp.leading).offset(10)
            make.trailing.equalTo(weightView.snp.trailing).offset(-10)
            make.top.equalTo(weightView.snp.top).offset(10)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
        weightTextField.snp.makeConstraints{ make in
            make.leading.equalTo(weightView.snp.leading).offset(100)
            make.top.equalTo(weightLabel.snp.bottom).offset(5)
            make.width.equalTo(20)
            make.bottom.equalTo(weightView.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
        }
        
        activeView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
//            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
//            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
            make.top.equalTo(weightView.snp.bottom).offset(10)
        }
    }
  
    
        
     
//        heighTextField.snp.makeConstraints { make in
//            make.top.equalTo(profileImage.snp.bottom).offset(20)
//            make.leading.equalToSuperview().offset(20)
//            make.centerX.equalToSuperview()
//            make.trailing.equalToSuperview().offset(-20)
//        }
//        weightTextField.snp.makeConstraints { make in
//            make.top.equalTo(heighTextField.snp.bottom).offset(20)
//            make.leading.equalToSuperview().offset(20)
//            make.centerX.equalToSuperview()
//            make.trailing.equalToSuperview().offset(-20)
//        }
//        actionButton.snp.makeConstraints { make in
//            make.top.equalTo(weightTextField.snp.bottom).offset(20)
//            make.leading.equalToSuperview().offset(20)
//            make.centerX.equalToSuperview()
//            make.trailing.equalToSuperview().offset(-20)
//        }
//        resultLabel.snp.makeConstraints { make in
//            make.top.equalTo(actionButton.snp.bottom).offset(100)
//            make.leading.equalToSuperview().offset(20)
//            make.centerX.equalToSuperview()
//            make.trailing.equalToSuperview().offset(-20)
//        }
    
    
    @objc func action() {
     
//        let result: Double = weigh/((heigh/100)*(heigh/100))
//
//        resultLabel.text = "\(Double(round(100 * result)/100.0))"
        
    }
}
