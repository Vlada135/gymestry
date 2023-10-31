//
//  ProfileController.swift
//  Gymestry
//
//  Created by Владислава on 1.10.23.
//

import Foundation
import UIKit
import SnapKit
import PhotosUI
import FirebaseAuth

class ProfileController: UIViewController {
    
    var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.frame = view.bounds
        scroll.contentSize = contentSize
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.frame.size = contentSize
        return view
    }()
    
    private lazy var profileView = InputView()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        makeConstraints()
        setupGestures()
        setupControllerMode()
    }
    private func makeLayout() {
        view.backgroundColor = .white
        title = "Профиль"
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(profileView)
        profileView.addSubview(avatarImageView)
        profileView.addSubview(addPhotoImage)
        
    }
    
    private func makeConstraints() {
        
        profileView.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(contentView).inset(16)
            make.top.equalTo(contentView.snp.top).offset(10)
        }
        avatarImageView.snp.makeConstraints{ make in
            make.leading.equalTo(profileView.snp.leading).offset(20)
            make.height.width.equalTo(100)
            make.centerY.equalTo(profileView)
        }
        addPhotoImage.snp.makeConstraints{ make in
            make.bottom.equalTo(profileView.snp.bottom).inset(30)
            make.leading.equalTo(avatarImageView.snp.leading).offset(67)
            make.width.equalTo(26)
        }
    }
    
    private func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(addPhoto))
        addPhotoImage.addGestureRecognizer(tap)
    }
    private func setupControllerMode() {
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
    
    @objc private func saveAvatar(imageData: Data) {
        guard let user = Auth.auth().currentUser else { return }

        let child = Environment.storage.child("images/\(user.uid).jpg")
//        Код снизу создаёт папку и добавляет картинку со случайным ID
//        let child = Environment.storage.child("\(user.uid)/\(UUID().uuidString).jpg")
        
        _ = child.putData(imageData, metadata: nil) { (metadata, error) in
            guard metadata != nil else {
                print("Картинка не была загружена")
                return
            }
        }
    }
}

extension ProfileController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: .none)
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] reading, error in
                guard let image = reading as? UIImage,
                      error == nil,
                      let imageData = image.jpegData(compressionQuality: 1)
                else { return }
                
                self?.saveAvatar(imageData: imageData)
                DispatchQueue.main.async { [weak self] in
                    self?.avatarImageView.image = image
                }
                
                //                ниже код получения абсолютного пути для нашего файл (то есть пути где он физически на нашем девайсе)
                result.itemProvider.loadFileRepresentation(forTypeIdentifier: "public.image") { [weak self] url, _ in
                    print(url)
                }
            }
        }
    }
}
