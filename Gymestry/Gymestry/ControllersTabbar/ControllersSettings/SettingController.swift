//
//  SettingController.swift
//  Gymestry
//
//  Created by Владислава on 11.11.23.
//

import Foundation
import UIKit
import SnapKit
import FirebaseAuth
import PhotosUI


class SettingController: UIViewController {
    
    var list: [[Settings]] = [[.password], [.help], [.notifications], [.feedback], [.logout]]
    
    private lazy var accountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.text = "Aккаунт"
        label.isUserInteractionEnabled = true
        label.textAlignment = .left
        return label
    }()
    
    private lazy var accountView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 40
        image.layer.borderWidth = 1
        image.contentMode = .scaleAspectFill
        image.layer.borderColor = UIColor.clear.cgColor
        image.image = UIImage(systemName: "person.crop.circle.fill")
        image.tintColor = .gray
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.text = "Name"
        label.isUserInteractionEnabled = true
        label.textAlignment = .left
        return label
    }()
    
    private lazy var editImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = .black
        image.clipsToBounds = true
        return image
    }()
    private lazy var settingsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.text = "Настройки"
        label.isUserInteractionEnabled = true
        label.textAlignment = .left
        return label
    }()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(SettingCell.self, forCellWithReuseIdentifier: SettingCell.id)
        return collection
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readUserData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        makeConstraints()
        setupGestures()
    }
    
    private func makeLayout() {
        view.backgroundColor = .white
        title = "Настройки"
        view.addSubview(accountLabel)
        view.addSubview(accountView)
        accountView.addSubview(avatarImageView)
        accountView.addSubview(nameLabel)
        accountView.addSubview(editImage)
        view.addSubview(settingsLabel)
        view.addSubview(collectionView)
        
    }
    
    private func makeConstraints() {
        accountLabel.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        accountView.snp.makeConstraints { make in
            make.top.equalTo(accountLabel.snp.bottom).offset(10)
            make.height.equalTo(80)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        avatarImageView.snp.makeConstraints{ make in
            make.height.width.equalTo(80)
            make.leading.equalTo(accountView.snp.leading).offset(0)
            make.centerY.equalTo(accountView)
        }
        nameLabel.snp.makeConstraints{ make in
            make.centerY.equalTo(accountView)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(12)
        }
        editImage.snp.makeConstraints{ make in
            make.trailing.equalTo(accountView.snp.trailing).offset(-5)
            make.height.width.equalTo(18)
            make.centerY.equalTo(accountView)
        }
        settingsLabel.snp.makeConstraints{ make in
            make.top.equalTo(accountView.snp.bottom).offset(60)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(settingsLabel.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(0)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
    }
    
    private func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(editAccountInf))
        accountView.addGestureRecognizer(tap)
    }
    
    @objc private func editAccountInf() {
        self.navigationController?.pushViewController(EditAccountController(), animated: true)
    }
    
    func signOutAlert() {
        let alert = UIAlertController(
            title: "Обратите внимание",
            message: "Вы уверены, что хотите выйти?",
            preferredStyle: .alert
        )
        
        let signOutAction = UIAlertAction(title: "Выйти", style: .destructive) { [weak self] _ in
            self?.signOutAction()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        
        alert.addAction(signOutAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    private func readUserData() {
        guard let user = Auth.auth().currentUser else { return }
        
        Environment.ref.child("users/\(user.uid)/userData").observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let contactValue = snapshot.value as? [String: Any],
                  let contactForEdit = try? PersonData(key: user.uid, dict: contactValue)
            else { return }
            
            self?.nameLabel.text = contactForEdit.name
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
    
    func signOutAction() {
        do {
            try Auth.auth().signOut()
            if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                scene.setLogIn()
            }
        }
        catch { print("already logged out") }
    }
}

extension SettingController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int  {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let point = list[indexPath.section][indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingCell.id, for: indexPath)
        guard let listcell = cell as? SettingCell else { return .init() }
        listcell.set(point: point)
        return listcell
    }
}

extension SettingController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch (indexPath.section) {
        case 4:
            signOutAlert()
        default:
            print("default")
        }
    }
}

extension SettingController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
}
