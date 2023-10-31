//
//  SignInController.swift
//  Gymestry
//
//  Created by Владислава on 6.10.23.
//

import UIKit
import SnapKit

class SignInController: UIViewController {
    
    lazy var mainView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "login")
        view.alpha = 0.5
        return view
    }()
    
    lazy var loginView = InputView()
    
    lazy var imageView: UIView = {
        let view = InputView()
        view.layer.cornerRadius = 50
        return view
    }()

    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 50
        image.clipsToBounds = true
        image.image = UIImage(named: "AppIcon")
        return image
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

      
    }
    private func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loginView.snp.makeConstraints { make in
//            make.height.equalTo(500)
            make.center.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(150)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-150)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-40)
        }
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(100)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(loginView.snp.top).offset(60)
//            make.leading.equalTo(view.safeAreaLayoutGuide).offset(50)
//            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-50)
        }
        image.snp.makeConstraints { make in
            make.height.width.equalTo(100)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(loginView.snp.top).offset(60)
//            make.leading.equalTo(view.safeAreaLayoutGuide).offset(50)
//            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-50)
        }
    }
}

