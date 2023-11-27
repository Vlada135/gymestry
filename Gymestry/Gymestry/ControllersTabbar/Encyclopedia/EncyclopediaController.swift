//
//  EncyclopediaController.swift
//  Gymestry
//
//  Created by Владислава on 30.10.23.
//

import Foundation
import UIKit
import SnapKit

class EncyclopediaController: UIViewController {
    var encyclopedia: [Encyclopedia] = []
    
    private lazy var addButton: UIButton = {
        let addButton = UIButton(type: .system)
        addButton.addTarget(self, action: #selector(action), for: .touchUpInside)
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
        return addButton
    }()
     
   
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(EncyclopediaCell.self, forCellWithReuseIdentifier: EncyclopediaCell.id)
        return collection
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        makeConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readList()
    }
    
    private func makeLayout() {
        view.backgroundColor = .white
        title = "Энциклопедия"
        view.addSubview(addButton)
        view.addSubview(collectionView)
    }
    
    private func makeConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func action() {
        let secondController = AddEncyclopedia(mode: .create)
        self.navigationController?.pushViewController(secondController, animated: true)
    }
    
    private func parseData(_ dict: [String : Any]) {
        encyclopedia.removeAll()
        for (key, value) in dict {
            guard let answer = value as? [String: Any] else { continue }
            guard let new = try? Encyclopedia(
                key: key,
                dict: answer
            ) else { continue }
            
            self.encyclopedia.append(new)
            self.encyclopedia.sort(by: {$0.id ?? "" > $1.id ?? ""})
        }
        self.collectionView.reloadData()
    }
    
    private func readList() {
        Environment.ref.child("encyclopedies").observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let contactsDict = (snapshot.value as? [String: Any]) else { return }
            self?.parseData(contactsDict)
        }
        
    }
}

extension EncyclopediaController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return encyclopedia.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EncyclopediaCell.id, for: indexPath)
        guard let listcell = cell as? EncyclopediaCell else { return .init() }
        listcell.setEncyclopedia(encyclopedia: encyclopedia[indexPath.row])
        return listcell
    }
}

extension EncyclopediaController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let secondController = EncyclopediaDetails()
        secondController.set(encyclopedia: encyclopedia[indexPath.row])
        self.navigationController?.pushViewController(secondController, animated: true)
    }
}

extension EncyclopediaController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 150)
    }
}

