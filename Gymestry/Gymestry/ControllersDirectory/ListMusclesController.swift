//
//  ListMusclesController.swift
//  Gymestry
//
//  Created by Владислава on 17.09.23.
//

import Foundation
import SnapKit
import UIKit

class ListMusclesController: UIViewController {
    var list: [[GroupMusclesModel]] = [[.breast], [.back], [.legs], [.glutes], [.deltas], [.biceps], [.triceps], [.forearm], [.abs]]
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(ListMusclesCell.self, forCellWithReuseIdentifier: ListMusclesCell.id)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        makeConstraints()
    }
    private func makeLayout() {
        view.backgroundColor = .white
        title = "Упражнения"
        view.addSubview(collectionView)
    }
    private func makeConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ListMusclesController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int  {
        return list.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let point = list[indexPath.section][indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListMusclesCell.id, for: indexPath)
        guard let listcell = cell as? ListMusclesCell else { return .init() }
        listcell.set(point: point)
        return listcell
    }
}

extension ListMusclesController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        return print("Press")
    }
}

extension ListMusclesController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}
