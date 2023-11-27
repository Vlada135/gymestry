//
//  EditAccountController.swift
//  Gymestry
//
//  Created by Владислава on 13.11.23.
//

import Foundation
import UIKit
import SnapKit
import PhotosUI
import FirebaseAuth
import FirebaseDatabase

class EditAccountController: UIViewController {
    
    private lazy var saveButton: GradientButton = {
        let button = GradientButton(type: .system)
        button.tintColor = .white
        button.startColor = UIColor.black
        button.endColor = UIColor.gray
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        button.setTitle(
            "Сохранить",
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(saveData),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 75
        image.layer.borderWidth = 1
        image.contentMode = .scaleAspectFill
        image.layer.borderColor = UIColor.clear.cgColor
        image.image = UIImage(systemName: "person.crop.circle.fill")
        image.tintColor = .gray
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var addPhotoImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 18
        image.layer.borderWidth = 3
        image.contentMode = .scaleAspectFill
        image.layer.borderColor = UIColor.black.cgColor
        image.image = UIImage(systemName: "pencil.circle.fill")
        image.tintColor = .black
        image.backgroundColor = .white
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var inputName: InputLabField = {
        let field = InputLabField(placeholder: "Введите ваше имя", textLabel: "Ваше полное имя")
        return field
    }()
    
    private lazy var inputHeight: InputLabField = {
        let field = InputLabField(placeholder: "Ваш рост, см", textLabel: "Введите ваш рост")
        return field
    }()
    
    private lazy var inputAge: InputLabField = {
        let field = InputLabField(placeholder: "Ваш возраст", textLabel: "Введите ваш возраст")
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        makeConstraints()
        setupControllerMode()
        setupGestures()
    }
    
    private func makeLayout() {
        view.backgroundColor = .white
        title = "Настройка аккаунта"
        view.addSubview(saveButton)
        view.addSubview(avatarImageView)
        view.addSubview(addPhotoImage)
        view.addSubview(inputName)
        view.addSubview(inputHeight)
        view.addSubview(inputHeight)
        view.addSubview(inputAge)
    }
    
    private func makeConstraints() {
        
        avatarImageView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.width.equalTo(150)
            make.centerX.equalToSuperview()
        }
        addPhotoImage.snp.makeConstraints{ make in
            make.bottom.equalTo(avatarImageView.snp.bottom).offset(-6)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(-40)
            make.width.height.equalTo(36)
        }
        inputName.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(avatarImageView.snp.bottom).offset(50)
            make.height.equalTo(80)
        }
        inputHeight.snp.makeConstraints { make in
            make.top.equalTo(inputName.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(80)
        }
        
        inputAge.snp.makeConstraints { make in
            make.top.equalTo(inputHeight.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(80)
        }
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(21)
            make.height.equalTo(60)
        }
    }
    
    private func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(addPhoto))
        addPhotoImage.addGestureRecognizer(tap)
    }
    
    @objc private func saveData() {
        guard let image = self.avatarImageView.image,
              let imageData = image.jpegData(compressionQuality: 0.2)
        else { return }
        guard let user = Auth.auth().currentUser else { return }
        let child = Environment.storage.child("images/\(user.uid).jpg")
        child.putData(imageData, metadata: nil) { [weak self] (metadata, error) in
            guard metadata != nil else {
                print("Картинка не была загружена")
                return
            }
            child.downloadURL { [weak self] url, error in
                guard let self,
                      let url,
                      let name = inputName.text,
                      let height = inputHeight.text,
                      let weight = inputAge.text,
                      let user = Auth.auth().currentUser
                else { return }
                
                let contact = PersonData(
                    name: name,
                    height: height,
                    weight: weight,
                    personImage: url.absoluteString
                )
                
                Environment.ref.child("users/\(user.uid)/userData").setValue(contact.asDict)
                Environment.ref.child("users/\(user.uid)/userData").updateChildValues(contact.asDict)
                
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func setupControllerMode() {
        
        guard let user = Auth.auth().currentUser else { return }
        Environment.ref.child("users/\(user.uid)/userData").observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let contactValue = snapshot.value as? [String: Any],
                  let contactForEdit = try? PersonData(key: user.uid, dict: contactValue)
            else { return }
            
            self?.inputName.text = contactForEdit.name
            self?.inputHeight.text = contactForEdit.height
            self?.inputAge.text = contactForEdit.age
        }
        guard let user = Auth.auth().currentUser else { return }
        
        let child = Environment.storage.child("images/\(user.uid).jpg")
        
        child.downloadURL { (url, error) in
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let url,
                      let data = try? Data(contentsOf: url),
                      let image = UIImage(data: data)
                else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.avatarImageView.image = image
                }
            }
        }
    }
    
    
    @objc private func addPhoto() {
        print("Select image dialog")
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 1
        config.filter = PHPickerFilter.any(of: [.images])
        let pickerVC = PHPickerViewController(configuration: config)
        pickerVC.delegate = self
        present(pickerVC, animated: true)
    }
}

extension EditAccountController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: .none)
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] reading, error in
                guard let image = reading as? UIImage,
                      error == nil
                else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.avatarImageView.image = image
                }
            }
        }
    }
}
