//
//  InputLabField.swift
//  Gymestry
//
//  Created by Владислава on 19.11.23.
//


import UIKit
import SnapKit

class InputLabField: UIView {
    
    private lazy var inputField: UITextField = {
        let field = UITextField()
        field.textAlignment = .left
        field.layer.cornerRadius = 12
        field.backgroundColor = .systemGray5
        field.leftView = UIView(frame: .init(x: 0, y: 0, width: 10, height: 10))
        field.leftViewMode = .always
        return field
    }()
    
    private lazy var inputLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .darkGray
        label.isUserInteractionEnabled = true
        label.textAlignment = .left
        return label
    }()
    
    var textLabel: String? {
        set { inputLabel.text = newValue }
        get { return inputLabel.text ?? ""}
    }

    var placeholder: String? {
        set { inputField.placeholder = newValue }
        get { return inputField.placeholder ?? ""}
    }
    
    var text: String? {
        set { inputField.text = newValue }
        get { return inputField.text ?? ""}
    }
    
    init(
        placeholder: String? = nil,
        textLabel: String? = nil,
        text: String? = nil

    ) {
        super.init(frame: .zero)
        makeLayout()
        makeConstraints()
        
        self.placeholder = placeholder
        self.textLabel = textLabel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeLayout() {
        self.addSubview(inputLabel)
        self.addSubview(inputField)
    }
    
    private func makeConstraints() {

        inputLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(21)
            make.height.equalTo(20)
        }
        
        inputField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(21)
            make.top.equalTo(inputLabel.snp.bottom).inset(-10)
            make.height.equalTo(50)
        }
    }
}

