//
//  AddEncyclopedia.swift
//  Gymestry
//
//  Created by Владислава on 24.11.23.
//

import Foundation
import SnapKit
import UIKit
import FirebaseAuth
import FirebaseDatabase
import PhotosUI
import FirebaseStorage

class AddEncyclopedia: UIViewController {
    
    var category: Bool = false
    var categoryIDAdd: String = ""
    
    
    private lazy var nameInput = InputField()
    
    private lazy var sporteatLabel: InputLabel = {
        let label = InputLabel()
        label.text = "Cпортивная добавка"
        return label
    }()
    private lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 50
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
        image.heightAnchor.constraint(equalToConstant: 26).isActive = true
        image.layer.cornerRadius = 13
        image.layer.borderWidth = 3
        image.contentMode = .scaleAspectFill
        image.layer.borderColor = UIColor.black.cgColor
        image.image = UIImage(systemName: "plus.circle.fill")
        image.tintColor = .black
        image.backgroundColor = .white
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var descriptionText: UITextView = {
        let view = UITextView()
        view.textColor = .black
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    
    private lazy var actionButton: UIButton = {
        let button = GradientButton(type: .system)
        button.tintColor = .white
        button.startColor = UIColor.purple
        button.endColor = UIColor.systemPink
        button.setTitle("Сохранить", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.addTarget(
            self,
            action: #selector(save),
            for: .touchUpInside
        )
        return button
    }()
    
    private let mode: ControllerMode
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        makeConstraints()
        setupGestures()
        setupControllerMode()
    }
    
    init(mode: ControllerMode) {
        self.mode = mode
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.view.addSubview(nameInput)
        self.view.addSubview(sporteatLabel)
        self.view.addSubview(avatarImageView)
        self.view.addSubview(descriptionText)
        self.view.addSubview(actionButton)
    }
    
    private func makeConstraints() {
        sporteatLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        nameInput.snp.makeConstraints { make in
            make.top.equalTo(sporteatLabel.snp.bottom).inset(-5)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        avatarImageView.snp.makeConstraints{ make in
            make.top.equalTo(nameInput.snp.bottom).inset(-5)
            make.height.width.equalTo(100)
            make.centerX.equalToSuperview()
        }
        descriptionText.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).inset(-20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(actionButton.snp.top).inset(-5)
            
        }
        actionButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(addPhoto))
        avatarImageView.addGestureRecognizer(tap)
    }
    
    private func setupControllerMode() {
        switch mode {
        case .create:
            title = "Создать статью"
        case .edit(let editable):
            title = "Изменить статью"
            
            guard let encyclopediId = editable.id else { return }
            Environment.ref.child("encyclopedies/\(encyclopediId)/encyclopedia").observeSingleEvent(of: .value) { [weak self] snapshot  in
                guard let listValue = snapshot.value as? [String: Any],
                      let listForEdit = try? Encyclopedia(key: encyclopediId, dict: listValue)
                else { return }
                self?.nameInput.text = listForEdit.title
            }
        }
    }
    
    
    @objc private func save() {
        
        guard let image = self.avatarImageView.image,
              let imageData = image.jpegData(compressionQuality: 0.2)
        else { return }
        let fileName = UUID().uuidString
        let child = Environment.storage.child("encyclopedia/\(fileName).jpg")
        child.putData(imageData, metadata: nil) { [weak self] (metadata, error) in
            guard metadata != nil else {
                print("Картинка не была загружена")
                return
            }
            child.downloadURL { [weak self] url, error in
                guard let self,
                      let title = self.nameInput.text,
                      let url
                else { return }
                
                let groupList = Encyclopedia(
                    id: nil,
                    title: title,
                    encyclopediaImage: url.absoluteString,
                    description: descriptionText.text
                )
                
                switch self.mode {
                case .create:
                    Environment.ref.child("encyclopedies").childByAutoId().setValue(groupList.asDict)
                case .edit(let editable):
                    guard let id = editable.id else { return }
                    Environment.ref.child("encyclopedies/\(id)").updateChildValues(groupList.asDict)
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
    
    
    @objc func settingAction() {
        let secondController = SettingController()
        self.navigationController?.pushViewController(secondController, animated: true)
    }
}

extension AddEncyclopedia: PHPickerViewControllerDelegate {
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
