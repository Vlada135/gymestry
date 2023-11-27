//
//  CategorySporteatController.swift
//  Gymestry
//
//  Created by Владислава on 24.11.23.
//

import Foundation
import SnapKit
import UIKit

class CategorySporteatController: UIViewController {

    var sporteat: [Sporteat] = []
    var idCategory : String = ""
    var categoryName: String = ""
    
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
        collection.register(SporteatCell.self, forCellWithReuseIdentifier: SporteatCell.id)
        return collection
    }()
    
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
        title = categoryName
        view.addSubview(addButton)
        view.addSubview(collectionView)
    }
    
    private func makeConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func action() {
        let secondController = AddSportEat(mode: .create, modeID: .withID)
        secondController.categoryIDAdd = self.idCategory
        self.navigationController?.pushViewController(secondController, animated: true)
    }
    
    private func parseData(_ dict: [String : Any]) {
        sporteat.removeAll()
        for (key, value) in dict {
            guard let answer = value as? [String: Any] else { continue }
            guard let new = try? Sporteat(
                key: key,
                dict: answer
            ) else { continue }
            if new.idCategory == self.idCategory {
                self.sporteat.append(new)
                self.sporteat.sort(by: {$0.id ?? "" > $1.id ?? ""})
            }
            self.collectionView.reloadData()
        }
    }
    
    private func readList() {
        Environment.ref.child("sporteatCategories").observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let contactsDict = (snapshot.value as? [String: Any]) else { return }
            self?.parseData(contactsDict)
        }
    }
}


extension CategorySporteatController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sporteat.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SporteatCell.id, for: indexPath)
        guard let listcell = cell as? SporteatCell else { return .init() }
        listcell.setSporteat(sporteat: sporteat[indexPath.row])
        return listcell
    }
}

extension CategorySporteatController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let secondController = EatDetails()
        secondController.set(eat: sporteat[indexPath.row])
        self.navigationController?.pushViewController(secondController, animated: true)
    }
}

extension CategorySporteatController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}

