//
//  AddSportEat.swift
//  Gymestry
//
//  Created by Владислава on 23.11.23.
//
import Foundation
import SnapKit
import UIKit
import FirebaseAuth
import FirebaseDatabase
import PhotosUI
import FirebaseStorage

enum IDMode {
    case withID
    case withoutID
}

class AddSportEat: UIViewController {
    
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
    
    private lazy var descriptionText: UITextView = {
        let view = UITextView()
        view.textColor = .black
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var categoryView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var categorySelectSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.addTarget(self, action: #selector(selectDetail), for: .valueChanged)
        switcher.setOn(false, animated: false)
        switcher.onTintColor = .purple
        return switcher
    }()
    
    private lazy var categotyLabel: InputLabel = {
        let label = InputLabel()
        label.text = "Наличие подкатегорий"
        label.textAlignment = .left
        return label
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
    private let modeID: IDMode
    
    private let mode: ControllerMode
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        makeConstraints()
        setupGestures()
        setupControllerMode()
    }
    
    init(mode: ControllerMode, modeID: IDMode) {
        self.mode = mode
        self.modeID = modeID
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.view.addSubview(nameInput)
        self.view.addSubview(sporteatLabel)
        self.view.addSubview(avatarImageView)
        view.addSubview(categoryView)
        categoryView.addSubview(categotyLabel)
        categoryView.addSubview(categorySelectSwitch)
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
        categoryView.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).inset(-20)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        categotyLabel.snp.makeConstraints { make in
            make.leading.equalTo(categoryView.snp.leading).inset(15)
            make.height.equalTo(20)
            make.centerY.equalTo(categoryView)
        }
        categorySelectSwitch.snp.makeConstraints { make in
            make.trailing.equalTo(categoryView.snp.trailing).inset(15)
            make.centerY.equalTo(categoryView)
        }
        descriptionText.snp.makeConstraints { make in
            make.top.equalTo(categoryView.snp.bottom).inset(-20)
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
    
    @objc private func selectDetail(_ sender:UISwitch!) {
        if (sender.isOn == true){
            self.category = true
            print("UISwitch state is now ON")
        }
        else{
            self.category = false
            print("UISwitch state is now Off")
        }
    }
    
    
    private func setupControllerMode() {
        switch modeID{
        case .withoutID:
            switch mode {
            case .create:
                title = "Создать спортивную добавку"
            case .edit(let editable):
                title = "Изменить спортивную добавку"
                
                guard let sporteatId = editable.id else { return }
                Environment.ref.child("sporteats/\(sporteatId)/sporteat").observeSingleEvent(of: .value) { [weak self] snapshot  in
                    guard let listValue = snapshot.value as? [String: Any],
                          let listForEdit = try? Sporteat(key: sporteatId, dict: listValue)
                    else { return }
                    self?.nameInput.text = listForEdit.sporteat
                }
            }
        case .withID:
            switch mode {
            case .create:
                title = "Создать спортивную добавку"
            case .edit(let editable):
                title = "Изменить спортивную добавку"
                
                guard let sporteatId = editable.id else { return }
                Environment.ref.child("sporteatCategories/\(sporteatId)/sporteatCategory").observeSingleEvent(of: .value) { [weak self] snapshot  in
                    guard let listValue = snapshot.value as? [String: Any],
                          let listForEdit = try? Sporteat(key: sporteatId, dict: listValue)
                    else { return }
                    self?.nameInput.text = listForEdit.sporteat
                }
            }
        }
    }
    
    @objc private func save() {
        switch modeID {
            
        case .withoutID:
            guard let image = self.avatarImageView.image,
                  let imageData = image.jpegData(compressionQuality: 0.2)
            else { return }
            let fileName = UUID().uuidString
            let child = Environment.storage.child("sportfood/\(fileName).jpg")
            child.putData(imageData, metadata: nil) { [weak self] (metadata, error) in
                guard metadata != nil else {
                    print("Картинка не была загружена")
                    return
                }
                child.downloadURL { [weak self] url, error in
                    guard let self,
                          let sporteat = self.nameInput.text,
                          let url
                    else { return }
                    
                    let groupList = Sporteat(
                        id: nil,
                        sporteat: sporteat,
                        sporteatImage: url.absoluteString,
                        description: descriptionText.text,
                        categorySelect: category
                    )
                    
                    switch self.mode {
                    case .create:
                        Environment.ref.child("sporteats").childByAutoId().setValue(groupList.asDict)
                    case .edit(let editable):
                        guard let id = editable.id else { return }
                        Environment.ref.child("sporteats/\(id)").updateChildValues(groupList.asDict)
                    }
                }
                
            }
        case .withID:
            guard let image = self.avatarImageView.image,
                  let imageData = image.jpegData(compressionQuality: 0.2)
            else { return }
            let fileName = UUID().uuidString
            let child = Environment.storage.child("sportfood/\(fileName).jpg")
            child.putData(imageData, metadata: nil) { [weak self] (metadata, error) in
                guard metadata != nil else {
                    print("Картинка не была загружена")
                    return
                }
                child.downloadURL { [weak self] url, error in
                    guard let self,
                          let sporteat = self.nameInput.text,
                          let url
                    else { return }
                    
                    let groupList = Sporteat(
                        id: nil,
                        sporteat: sporteat,
                        sporteatImage: url.absoluteString,
                        description: descriptionText.text,
                        categorySelect: category,
                        idCategory: categoryIDAdd
                    )
                    
                    switch self.mode {
                    case .create:
                        Environment.ref.child("sporteatCategories").childByAutoId().setValue(groupList.asDict)
                    case .edit(let editable):
                        guard let id = editable.id else { return }
                        Environment.ref.child("sporteatCategories/\(id)").updateChildValues(groupList.asDict)
                    }
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

extension AddSportEat: PHPickerViewControllerDelegate {
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
