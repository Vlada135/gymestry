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
   
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collection.dataSource = self
        collection.delegate = self
//        collection.register(DirectoryCell.self, forCellWithReuseIdentifier: DirectoryCell.id)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        makeConstraints()
    }
    private func makeLayout() {
        view.backgroundColor = .white
        title = "Программа"
        view.addSubview(collectionView)
    }
    
    private func makeConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//extension EncyclopediaController: UICollectionViewDataSource {
////    func numberOfSections(in collectionView: UICollectionView) -> Int  {
////        //        return data.count
////    }
////    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        //        return data[section].count
////    }
////
////    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        //        let point = data[indexPath.section][indexPath.row]
////        //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DirectoryCell.id, for: indexPath)
////        //        guard let directorycell = cell as? DirectoryCell else { return .init() }
////        //        directorycell.set(point: point)
////        //        return directorycell
////        //    }
////    }
//}
extension EncyclopediaController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension EncyclopediaController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 150)
    }
}

