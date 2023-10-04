//
//  ExercisesListController.swift
//  Gymestry
//
//  Created by Владислава on 25.09.23.
//

import Foundation
import SnapKit
import UIKit

class ExercisesListController: UIViewController {
    var list: [[GroupMusclesModel]] = [[.breast], [.back], [.legs], [.glutes], [.deltas], [.biceps], [.triceps], [.forearm], [.abs]]

    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(ExercisesCell.self, forCellWithReuseIdentifier: ExercisesCell.id)
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

extension ExercisesListController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int  {
        return list.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let point = list[indexPath.section][indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExercisesCell.id, for: indexPath)
        guard let listcell = cell as? ExercisesCell else { return .init() }
//        listcell.set(point: point)
        return listcell
    }
}

extension ExercisesListController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        return print("Press")
    }
}

extension ExercisesListController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}

