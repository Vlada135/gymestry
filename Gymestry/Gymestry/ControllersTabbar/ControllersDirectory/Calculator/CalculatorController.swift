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
        CGSize(width: view.frame.width, height: view.frame.height + 200)
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
    
    lazy var genderView = InputView()
    lazy var ageView = InputView()
    lazy var heightView = InputView()
    lazy var weightView = InputView()
    lazy var activeView = InputView()
    lazy var aimView = InputView()
    
    
    lazy var genderLabel: UILabel = {
        let label = InputLabel()
        label.text = "Пол"
        return label
    }()
    lazy var ageLabel: UILabel = {
        let label = InputLabel()
        label.textAlignment = .center
        label.text = "Возраст"
        return label
    }()
    lazy var weightLabel: UILabel = {
        let label = InputLabel()
        label.textAlignment = .center
        label.text = "Вес"
        return label
    }()
    lazy var heightLabel: UILabel = {
        let label = InputLabel()
        label.textAlignment = .center
        label.text = "Рост"
        return label
    }()
    lazy var activeLabel: UILabel = {
        let label = InputLabel()
        label.text = "Активность"
        return label
    }()
    lazy var aimLabel: UILabel = {
        let label = InputLabel()
        label.text = "Цель"
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
    
    private lazy var womanButton: ChooseButton = {
        let button = ChooseButton()
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
    private lazy var manButton: ChooseButton = {
        let button = ChooseButton()
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
    private lazy var minimumButton: ChooseButton = {
        let button = ChooseButton()
        button.setTitle(
            "Минимальная",
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(activeAction),
            for: .touchUpInside
        )
        return button
    }()
    private lazy var middleButton: ChooseButton = {
        let button = ChooseButton()
        button.setTitle(
            "Средняя",
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(activeAction),
            for: .touchUpInside
        )
        return button
    }()
    private lazy var hardButton: ChooseButton = {
        let button = ChooseButton()
        button.setTitle(
            "Высокая",
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(activeAction),
            for: .touchUpInside
        )
        return button
    }()
    private lazy var extraButton: ChooseButton = {
        let button = ChooseButton()
        button.setTitle(
            "Экстра",
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(activeAction),
            for: .touchUpInside
        )
        return button
    }()
    private lazy var lightButton: ChooseButton = {
        let button = ChooseButton()
        button.setTitle(
            "Слабая",
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(activeAction),
            for: .touchUpInside
        )
        return button
    }()
    private lazy var loseWeightButton: ChooseButton = {
        let button = ChooseButton()
        button.setTitle(
            "Потеря веса",
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(aimAction),
            for: .touchUpInside
        )
        return button
    }()
    private lazy var balanceWeightButton: ChooseButton = {
        let button = ChooseButton()
        button.setTitle(
            "Поддержка веса",
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(aimAction),
            for: .touchUpInside
        )
        return button
    }()
    private lazy var increaseWeightButton: ChooseButton = {
        let button = ChooseButton()
        button.setTitle(
            "Набор веса",
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(aimAction),
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
    
    private lazy var resultButton: UIButton = {
        let button = GradientButton(type: .system)
        button.tintColor = .white
        button.startColor = UIColor.black
        button.endColor = UIColor.gray
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        button.setTitle(
            "Рассчитать",
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(result),
            for: .touchUpInside
        )
        return button
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
        activeView.addSubview(activeLabel)
        activeView.addSubview(minimumButton)
        activeView.addSubview(lightButton)
        activeView.addSubview(middleButton)
        activeView.addSubview(hardButton)
        activeView.addSubview(extraButton)
        
        contentView.addSubview(aimView)
        aimView.addSubview(aimLabel)
        aimView.addSubview(loseWeightButton)
        aimView.addSubview(balanceWeightButton)
        aimView.addSubview(increaseWeightButton)
        
        contentView.addSubview(resultButton)
        
        
    }
    private func makeConstraints() {
        
        genderView.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(contentView).inset(16)
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
            make.height.equalTo(90)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(contentView).inset(16)
            make.top.equalTo(genderView.snp.bottom).offset(10)
        }
        
        ageLabel.snp.makeConstraints{ make in
            make.leading.trailing.equalTo(ageView).inset(20)
            make.top.equalTo(ageView.snp.top).offset(10)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
        ageTextField.snp.makeConstraints{ make in
            make.leading.equalTo(ageView.snp.leading).offset(20)
            make.top.equalTo(ageLabel.snp.bottom).offset(5)
            make.width.equalTo(20)
            make.bottom.equalTo(ageView.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
        }
        
        heightView.snp.makeConstraints { make in
            make.height.equalTo(90)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(contentView).inset(16)
            make.top.equalTo(ageView.snp.bottom).offset(10)
        }
        
        heightLabel.snp.makeConstraints{ make in
            make.leading.trailing.equalTo(heightView).inset(20)
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
            make.height.equalTo(90)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(contentView).inset(16)
            make.top.equalTo(heightView.snp.bottom).offset(10)
        }
        
        weightLabel.snp.makeConstraints{ make in
            make.leading.trailing.equalTo(weightView).inset(20)
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
            make.height.equalTo(220)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(contentView).inset(16)
            make.top.equalTo(weightView.snp.bottom).offset(10)
        }
        
        activeLabel.snp.makeConstraints{ make in
            make.leading.trailing.equalTo(activeView).inset(20)
            make.top.equalTo(activeView.snp.top).offset(10)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
        minimumButton.snp.makeConstraints{ make in
            make.leading.equalTo(activeView.snp.leading).offset(20)
            make.top.equalTo(activeLabel.snp.bottom).offset(10)
            make.width.equalTo(150)
            
        }
        lightButton.snp.makeConstraints{ make in
            make.trailing.equalTo(activeView.snp.trailing).offset(-20)
            make.top.equalTo(activeLabel.snp.bottom).offset(10)
            make.width.equalTo(150)
            
        }
        middleButton.snp.makeConstraints{ make in
            make.leading.equalTo(activeView.snp.leading).offset(20)
            make.top.equalTo(minimumButton.snp.bottom).offset(10)
            make.width.equalTo(150)
            
        }
        hardButton.snp.makeConstraints{ make in
            make.trailing.equalTo(activeView.snp.trailing).offset(-20)
            make.top.equalTo(lightButton.snp.bottom).offset(10)
            make.width.equalTo(150)
            
        }
        extraButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(hardButton.snp.bottom).offset(10)
            make.width.equalTo(150)
        }
        
        resultButton.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.bottom).inset(35)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        aimView.snp.makeConstraints { make in
            make.height.equalTo(220)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(contentView).inset(16)
            make.top.equalTo(activeView.snp.bottom).offset(10)
        }
        
        aimLabel.snp.makeConstraints{ make in
            make.leading.trailing.equalTo(aimView).inset(20)
            make.top.equalTo(aimView.snp.top).offset(10)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
        loseWeightButton.snp.makeConstraints{ make in
            make.leading.trailing.equalTo(aimView).inset(20)
            make.top.equalTo(aimLabel.snp.bottom).offset(10)
            make.width.equalTo(150)
            
        }
        balanceWeightButton.snp.makeConstraints{ make in
            make.leading.trailing.equalTo(aimView).inset(20)
            make.top.equalTo(loseWeightButton.snp.bottom).offset(10)
            make.width.equalTo(150)
            
        }
        increaseWeightButton.snp.makeConstraints{ make in
            make.leading.trailing.equalTo(aimView).inset(20)
            make.top.equalTo(balanceWeightButton.snp.bottom).offset(10)
            make.width.equalTo(150)
        }
    }
    
    @objc func action(sender: UIButton) {
        switch (sender) {
        case womanButton:
            womanButton.alpha = 1
            manButton.alpha = 0.5
            
        case manButton:
            womanButton.alpha = 0.5
            manButton.alpha = 1
        default:
            print("default")
        }
    }
    
    @objc func result(sender: UIButton) {
        guard let ageField = ageTextField.text,
              let heightField = heightTextField.text,
              let weightField = weightTextField.text,
              let weight = Double(weightField),
              let height = Double(heightField),
              let age = Double(ageField)
                
        else {return}
        
        var baseMetabolism = Double()
        var balance = Double()
        var result = Double()
        
        if womanButton.alpha == 1{
            baseMetabolism = (9.99*weight)+(6.25*height)-(4.92*age)-161
        } else {
            baseMetabolism = (9.99*weight)+(6.25*height)-(4.92*age)+5
        }
        
        if minimumButton.alpha == 1{
            balance = 1.200 * baseMetabolism
        } else if  lightButton.alpha == 1 {
            balance = 1.375 * baseMetabolism
        } else if  middleButton.alpha == 1 {
            balance = 1.550 * baseMetabolism
        } else if  hardButton.alpha == 1 {
            balance = 1.725 * baseMetabolism
        } else {
            balance = 1.900 * baseMetabolism
        }
        
        if loseWeightButton.alpha == 1{
            result = balance * 0.85
        } else if  balanceWeightButton.alpha == 1 {
            result = balance
        } else {
            result = balance * 1.15
        }
        let myresult = Int(result)
        
        let proteinD = (0.3 * result)/4
        let fatD = (0.3 * result)/9
        let carbD = (0.4 * result)/4
        
        let protein = Int(proteinD)
        let fat = Int(fatD)
        let carb = Int(carbD)
        
        let secondController = ResultController()
        secondController.caloriesLabel.text = "\(myresult) ккал/сутки"
        secondController.fatLabelresult.text = "\(fat) г"
        secondController.proteinLabelresult.text = "\(protein) г"
        secondController.carbLabelresult.text = "\(carb) г"
        self.navigationController?.pushViewController(secondController, animated: true)
    }
    
    @objc func activeAction(sender: UIButton) {
        switch (sender) {
        case minimumButton:
            minimumButton.alpha = 1
            lightButton.alpha = 0.5
            middleButton.alpha = 0.5
            hardButton.alpha = 0.5
            extraButton.alpha = 0.5
        case lightButton:
            minimumButton.alpha = 0.5
            lightButton.alpha = 1
            middleButton.alpha = 0.5
            hardButton.alpha = 0.5
            extraButton.alpha = 0.5
        case middleButton:
            minimumButton.alpha = 0.5
            lightButton.alpha = 0.5
            middleButton.alpha = 1
            hardButton.alpha = 0.5
            extraButton.alpha = 0.5
        case hardButton:
            minimumButton.alpha = 0.5
            lightButton.alpha = 0.5
            middleButton.alpha = 0.5
            hardButton.alpha = 1
            extraButton.alpha = 0.5
        case extraButton:
            minimumButton.alpha = 0.5
            lightButton.alpha = 0.5
            middleButton.alpha = 0.5
            hardButton.alpha = 0.5
            extraButton.alpha = 1
        default:
            print("default")
        }
    }
    @objc func aimAction(sender: UIButton) {
        switch (sender) {
        case loseWeightButton:
            loseWeightButton.alpha = 1
            balanceWeightButton.alpha = 0.5
            increaseWeightButton.alpha = 0.5
        case balanceWeightButton:
            loseWeightButton.alpha = 0.5
            balanceWeightButton.alpha = 1
            increaseWeightButton.alpha = 0.5
        case increaseWeightButton:
            loseWeightButton.alpha = 0.5
            balanceWeightButton.alpha = 0.5
            increaseWeightButton.alpha = 1
        default:
            print("default")
        }
    }
}
