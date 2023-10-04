//
//  SporteatController.swift
//  Gymestry
//
//  Created by Владислава on 18.09.23.
//

import Foundation
import SnapKit
import UIKit

class SporteatController: UIViewController {
    var list: [[SporteatModel]] = [[.protein], [.gainer], [.creatine], [.aminoAcids], [.weightLossDrugs], [.lCarnitine], [.vitamins], [.special], [.forJoints]]

    
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
    private func makeLayout() {
        view.backgroundColor = .white
        title = "Спортивное питание"
        view.addSubview(collectionView)
    }
    private func makeConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension SporteatController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int  {
        return list.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let point = list[indexPath.section][indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SporteatCell.id, for: indexPath)
        guard let listcell = cell as? SporteatCell else { return .init() }
        listcell.set(point: point)
        return listcell
    }
}

extension SporteatController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let secondController = EatDetails()
        secondController.set(eat: list[indexPath.section][indexPath.row])
        self.navigationController?.pushViewController(secondController, animated: true)
    }
}

extension SporteatController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}

