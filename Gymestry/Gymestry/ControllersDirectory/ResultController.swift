//
//  ResultController.swift
//  Gymestry
//
//  Created by Владислава on 28.10.23.
//

import Foundation
import SnapKit
import UIKit

class ResultController: UIViewController {
    
    private lazy var resutlView = InputView()
    
    private lazy var resultLabel: InputLabel = {
        let label = InputLabel()
        label.text = "Ваш результат"
        return label
    }()
    
    lazy var caloriesLabel: InputLabel = {
        let label = InputLabel()
        return label
    }()
    
    private lazy var labelPFC: InputLabel = {
        let label = InputLabel()
        label.text = "Ваш БЖУ"
        return label
    }()
    
    private lazy var stackPFC: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 30
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var proteinLabel: InputLabel = {
        let label = InputLabel()
        label.text = "Белки"
        return label
    }()
    private lazy var fatLabel: InputLabel = {
        let label = InputLabel()
        label.text = "Жиры"
        return label
    }()
    private lazy var carbLabel: InputLabel = {
        let label = InputLabel()
        label.text = "Углеводы"
        return label
    }()
     private lazy var stackPFCresult: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 30
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        return stack
    }()
    
     lazy var proteinLabelresult: InputLabel = {
        let label = InputLabel()
        return label
    }()
     lazy var fatLabelresult: InputLabel = {
        let label = InputLabel()
        return label
    }()
     lazy var carbLabelresult: InputLabel = {
        let label = InputLabel()
        return label
    }()
    private lazy var backToMainButton: UIButton = {
        let button = GradientButton(type: .system)
        button.tintColor = .white
        button.startColor = UIColor.black
        button.endColor = UIColor.gray
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        button.setTitle(
            "Вернуться в справочник",
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(backToMain),
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
        view.addSubview(resutlView)
        resutlView.addSubview(resultLabel)
        resutlView.addSubview(caloriesLabel)
        resutlView.addSubview(stackPFC)
        stackPFC.addArrangedSubview(fatLabel)
        stackPFC.addArrangedSubview(proteinLabel)
        stackPFC.addArrangedSubview(carbLabel)
        resutlView.addSubview(stackPFCresult)
        stackPFCresult.addArrangedSubview(fatLabelresult)
        stackPFCresult.addArrangedSubview(proteinLabelresult)
        stackPFCresult.addArrangedSubview(carbLabelresult)
        view.addSubview(backToMainButton)
    }
    private func makeConstraints() {
        
        resutlView.snp.makeConstraints { make in
            make.height.equalTo(160)
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        resultLabel.snp.makeConstraints{ make in
            make.leading.trailing.equalTo(resutlView).inset(20)
            make.top.equalTo(resutlView.snp.top).offset(10)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
        caloriesLabel.snp.makeConstraints{ make in
            make.leading.equalTo(resutlView.snp.leading).offset(20)
            make.top.equalTo(resultLabel.snp.bottom).offset(5)
            make.width.equalTo(20)
            make.centerX.equalToSuperview()
        }
        stackPFC.snp.makeConstraints{ make in
            make.leading.trailing.equalTo(resutlView).inset(20)
            make.top.equalTo(caloriesLabel.snp.bottom).offset(10)
        }
        stackPFCresult.snp.makeConstraints{ make in
            make.leading.trailing.equalTo(resutlView).inset(20)
            make.top.equalTo(stackPFC.snp.bottom).offset(10)
        }
        backToMainButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(35)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    @objc func backToMain(sender: UIButton) {
        self.navigationController?.pushViewController(DirectoryController(), animated: true)
    }
  
    
}
