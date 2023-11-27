//
//  RegistrController.swift
//  Gymestry
//
//  Created by Владислава on 6.10.23.
//

import UIKit
import SnapKit
import FirebaseAuth


class RegistrController: UIViewController {
    
    private lazy var mainView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "login")
        view.alpha = 0.8
        return view
    }()
    
    private lazy var loginView = InputView()
    
    private lazy var imageView: UIView = {
        let view = InputView()
        view.layer.cornerRadius = 50
        return view
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 50
        image.clipsToBounds = true
        image.image = UIImage(named: "AppIcon")
        return image
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.spacing = 5
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .darkGray
        label.text = "Логин"
        label.isUserInteractionEnabled = true
        label.textAlignment = .left
        return label
    }()
    private lazy var loginTextField: UITextField = {
        let field = UITextField()
        field.font = .systemFont(ofSize: 12, weight: .regular)
        field.placeholder = "Введите Ваш логин"
        field.textAlignment = .left
        field.layer.cornerRadius = 12
        field.backgroundColor = .systemGray5
        field.leftView = UIView(frame: .init(x: 0, y: 0, width: 10, height: 10))
        field.leftViewMode = .always
        return field
    }()
    
    private lazy var passowrdLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .darkGray
        label.text = "Пароль"
        label.isUserInteractionEnabled = true
        label.textAlignment = .left
        return label
    }()
    private lazy var passwordTextField: UITextField = {
        let field = UITextField()
        field.font = .systemFont(ofSize: 12, weight: .regular)
        field.placeholder = "Введите Ваш пароль"
        field.textAlignment = .left
        field.layer.cornerRadius = 12
        field.backgroundColor = .systemGray5
        field.leftView = UIView(frame: .init(x: 0, y: 0, width: 10, height: 10))
        field.leftViewMode = .always
        field.rightViewMode = .always
        field.rightView = eyeButton
        field.isSecureTextEntry = true
        return field
    }()
    
    private lazy var eyeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = .darkGray
        button.contentMode = .scaleAspectFill
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.addTarget(
            self,
            action: #selector(showPassword),
            for: .touchUpInside
        )
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 10)
        button.configuration = configuration
        return button
    }()
    
    private lazy var signInButton: UIButton = {
        let button = GradientButton(type: .system)
        button.tintColor = .white
        button.startColor = UIColor.black
        button.endColor = UIColor.gray
        button.setTitle("Зарегестрироваться", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.addTarget(
            self,
            action: #selector(registrationAction),
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
        view.backgroundColor = .gray
        view.addSubview(mainView)
        view.addSubview(loginView)
        view.addSubview(imageView)
        imageView.addSubview(image)
        loginView.addSubview(stack)
        stack.addSubview(loginLabel)
        stack.addSubview(loginTextField)
        stack.addSubview(passowrdLabel)
        stack.addSubview(passwordTextField)
        stack.addSubview(signInButton)
    }
    
    private func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        loginView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(320)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(100)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(loginView.snp.top).offset(60)
        }
        image.snp.makeConstraints { make in
            make.height.width.equalTo(100)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(loginView.snp.top).offset(60)
        }
        stack.snp.makeConstraints { make in
            make.top.equalTo(loginView.snp.top).offset(75)
            make.height.equalTo(260)
            make.centerX.equalToSuperview()
            make.leading.equalTo(loginView.snp.leading).offset(30)
            make.trailing.equalTo(loginView.snp.leading).offset(-30)
        }
        loginLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.leading.equalTo(stack.snp.leading).offset(0)
            make.trailing.equalTo(stack.snp.trailing).offset(0)
        }
        loginTextField.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(3)
            make.height.equalTo(40)
            make.leading.equalTo(stack.snp.leading).offset(0)
            make.trailing.equalTo(stack.snp.trailing).offset(0)
        }
        passowrdLabel.snp.makeConstraints { make in
            make.top.equalTo(loginTextField.snp.bottom).offset(10)
            make.height.equalTo(20)
            make.leading.equalTo(stack.snp.leading).offset(0)
            make.trailing.equalTo(stack.snp.trailing).offset(0)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passowrdLabel.snp.bottom).offset(3)
            make.height.equalTo(40)
            make.leading.equalTo(stack.snp.leading).offset(0)
            make.trailing.equalTo(stack.snp.trailing).offset(0)
        }
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.leading.equalTo(stack.snp.leading).offset(0)
            make.trailing.equalTo(stack.snp.trailing).offset(0)
        }
    }
    
    @objc private func registrationAction() {
        guard let login = loginTextField.text,
              let password = passwordTextField.text
        else { return }
        
        Auth.auth().createUser(withEmail: login, password: password) { [weak self] result, error in
            guard error == nil,
                  let result
            else {
                print(error!.localizedDescription)
                return
            }
        }
        self.navigationController?.pushViewController(LogInController(), animated: true)
    }
    
    @objc private func showPassword(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        if passwordTextField.isSecureTextEntry{
            self.eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        } else {
            self.eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
    
}
