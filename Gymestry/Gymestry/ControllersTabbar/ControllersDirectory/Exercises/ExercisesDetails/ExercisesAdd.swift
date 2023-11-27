//
//  ExercisesAdd.swift
//  Gymestry
//
//  Created by Владислава on 9.11.23.
//

import Foundation
import SnapKit
import UIKit
import FirebaseAuth
import FirebaseDatabase
import PhotosUI
import FirebaseStorage


class ExercisesAdd: UIViewController {
    
    var exercises: [Exercises] = []
    var groupIDAdd: String = ""
    var weightSelect: Bool = false
    var numberSelect: Bool = false
    var duractionSelect: Bool = false
    
    private lazy var exerciseInput = InputField()
    
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
    
    private lazy var exerciseLabel: InputLabel = {
        let label = InputLabel()
        label.text = "Упражнение"
        return label
    }()
    
    private lazy var weightLabel: InputLabel = {
        let label = InputLabel()
        label.text = "Вес/количество"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var numberLabel: InputLabel = {
        let label = InputLabel()
        label.text = "Количество"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var durationLabel: InputLabel = {
        let label = InputLabel()
        label.text = "Длительность"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var weightSelectView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = image.frame.height / 2
        image.layer.borderWidth = 1
        image.contentMode = .scaleAspectFill
        image.layer.borderColor = UIColor.clear.cgColor
        image.image = UIImage(systemName: "circle")
        image.tintColor = .purple
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var numberSelectView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = image.frame.height / 2
        image.layer.borderWidth = 1
        image.contentMode = .scaleAspectFill
        image.layer.borderColor = UIColor.clear.cgColor
        image.image = UIImage(systemName: "circle")
        image.tintColor = .purple
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var durationSelectView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = image.frame.height / 2
        image.layer.borderWidth = 1
        image.contentMode = .scaleAspectFill
        image.layer.borderColor = UIColor.clear.cgColor
        image.image = UIImage(systemName: "circle")
        image.tintColor = .purple
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var weightView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var numberView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var durationView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .white
        return view
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
        setupControllerMode()
        setupGestures()
    }
    
    init(mode: ControllerMode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        view.addSubview(exerciseInput)
        view.addSubview(exerciseLabel)
        view.addSubview(actionButton)
        view.addSubview(avatarImageView)
        view.addSubview(weightView)
        weightView.addSubview(weightLabel)
        weightView.addSubview(weightSelectView)
        view.addSubview(numberView)
        numberView.addSubview(numberLabel)
        numberView.addSubview(numberSelectView)
        view.addSubview(durationView)
        durationView.addSubview(durationLabel)
        durationView.addSubview(durationSelectView)
        self.view.addSubview(descriptionText)
    }
    
    private func makeConstraints() {
        exerciseLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        exerciseInput.snp.makeConstraints { make in
            make.top.equalTo(exerciseLabel.snp.bottom).inset(-5)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        avatarImageView.snp.makeConstraints{ make in
            make.top.equalTo(exerciseInput.snp.bottom).inset(-5)
            make.height.width.equalTo(100)
            make.centerX.equalToSuperview()
        }
        weightView.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).inset(-30)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        weightLabel.snp.makeConstraints { make in
            make.leading.equalTo(weightView.snp.leading).inset(15)
            make.height.equalTo(20)
            make.centerY.equalTo(weightView)
        }
        weightSelectView.snp.makeConstraints { make in
            make.trailing.equalTo(weightView.snp.trailing).inset(15)
            make.height.width.equalTo(25)
            make.centerY.equalTo(weightView)
        }
        numberView.snp.makeConstraints { make in
            make.top.equalTo(weightView.snp.bottom).inset(-5)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        numberLabel.snp.makeConstraints { make in
            make.leading.equalTo(numberView.snp.leading).inset(15)
            make.height.equalTo(20)
            make.centerY.equalTo(numberView)
        }
        numberSelectView.snp.makeConstraints { make in
            make.trailing.equalTo(numberView.snp.trailing).inset(15)
            make.height.width.equalTo(25)
            make.centerY.equalTo(numberView)
        }
        durationView.snp.makeConstraints { make in
            make.top.equalTo(numberView.snp.bottom).inset(-5)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        durationLabel.snp.makeConstraints { make in
            make.leading.equalTo(durationView.snp.leading).inset(15)
            make.height.equalTo(20)
            make.centerY.equalTo(durationView)
        }
        durationSelectView.snp.makeConstraints { make in
            make.trailing.equalTo(durationView.snp.trailing).inset(15)
            make.height.width.equalTo(25)
            make.centerY.equalTo(durationView)
        }
        descriptionText.snp.makeConstraints { make in
            make.top.equalTo(durationView.snp.bottom).inset(-20)
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
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(selectDetail))
        weightView.addGestureRecognizer(tap1)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(selectDetail))
        numberView.addGestureRecognizer(tap2)
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(selectDetail))
        durationView.addGestureRecognizer(tap3)
    }
    
    @objc private func selectDetail(_ tap: UITapGestureRecognizer) {
        switch (tap.view) {
        case weightView:
            self.weightSelectView.image = UIImage(systemName: "circle.fill")
            self.numberSelectView.image = UIImage(systemName: "circle")
            self.durationSelectView.image = UIImage(systemName: "circle")
            self.weightSelect = true
            self.numberSelect = false
            self.duractionSelect = false
        case numberView:
            self.numberSelectView.image = UIImage(systemName: "circle.fill")
            self.weightSelectView.image = UIImage(systemName: "circle")
            self.durationSelectView.image = UIImage(systemName: "circle")
            self.weightSelect = false
            self.numberSelect = true
            self.duractionSelect = false
        case durationView:
            self.durationSelectView.image = UIImage(systemName: "circle.fill")
            self.weightSelectView.image = UIImage(systemName: "circle")
            self.numberSelectView.image = UIImage(systemName: "circle")
            self.weightSelect = false
            self.numberSelect = false
            self.duractionSelect = true
        default:
            print("default")
        }
    }
    
    private func setupControllerMode() {
        switch mode {
        case .create:
            title = "Создать упражнение"
        case .edit(let editable):
            title = "Изменить упражнение"
            
            guard let exerciseId = editable.id else { return }
            
            Environment.ref.child("exercises/\(exerciseId)/exercise/").observeSingleEvent(of: .value) { [weak self] snapshot  in
                guard let listValue = snapshot.value as? [String: Any],
                      let listForEdit = try? Exercises(key: exerciseId, dict: listValue)
                else { return }
                
                self?.exerciseInput.text = listForEdit.exercise
                
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
    
    @objc private func save() {
        guard let image = self.avatarImageView.image,
              let imageData = image.jpegData(compressionQuality: 0.2)
        else { return }
        let fileName = UUID().uuidString
        let child = Environment.storage.child("exercises/\(fileName).jpg")
        child.putData(imageData, metadata: nil) { [weak self] (metadata, error) in
            guard metadata != nil else {
                print("Картинка не была загружена")
                return
            }
            child.downloadURL { [weak self] url, error in
                guard let self,
                      let exercise = exerciseInput.text,
                      let url
                else { return }
                
                let groupList = Exercises(
                    id: nil,
                    idGroup: groupIDAdd,
                    exercise: exercise,
                    description: descriptionText.text,
                    weightSelect: weightSelect,
                    numberSelect: numberSelect,
                    durationSelect: duractionSelect,
                    exerciseImage: url.absoluteString)
                
                switch mode {
                case .create:
                    Environment.ref.child("exercises").childByAutoId().setValue(groupList.asDict)
                case .edit(let editable):
                    guard let id = editable.id else { return }
                    Environment.ref.child("exercises/\(id)").updateChildValues(groupList.asDict)
                }
            }
        }
    }
}

extension ExercisesAdd: PHPickerViewControllerDelegate {
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
