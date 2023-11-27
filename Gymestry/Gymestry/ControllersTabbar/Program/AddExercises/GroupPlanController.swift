//
//  GroupPlanController.swift
//  Gymestry
//
//  Created by Владислава on 21.11.23.
//

import Foundation
import SnapKit
import UIKit
import FirebaseDatabase
import FirebaseAuth

class GroupPlanController: UIViewController {
    var group: [GroupOfMuscles] = []
    
    var planID: String = ""
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(ListMusclesCell.self, forCellWithReuseIdentifier: ListMusclesCell.id)
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
        title = "Упражнения"
        let addButton = UIButton(type: .system)
        addButton.addTarget(self, action: #selector(action), for: .touchUpInside)
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
        view.addSubview(collectionView)
    }
    
    private func makeConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func action() {
        let secondController = MusclesAdd(mode: .create)
        self.navigationController?.pushViewController(secondController, animated: true)
    }
    
    private func parseData(_ dict: [String : Any]) {
        group.removeAll()
        for (key, value) in dict {
            guard let answer = value as? [String: Any] else { continue }
            guard let new = try? GroupOfMuscles(
                key: key,
                dict: answer
            ) else { continue }
            
            self.group.append(new)
            self.group.sort(by: {$0.id ?? "" > $1.id ?? ""})
        }
        self.collectionView.reloadData()
    }
    
    private func readList() {
        Environment.ref.child("groups").observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let contactsDict = (snapshot.value as? [String: Any]) else { return }
            self?.parseData(contactsDict)
        }
    }
}

extension GroupPlanController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return group.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListMusclesCell.id, for: indexPath)
        guard let listcell = cell as? ListMusclesCell else { return .init() }
        listcell.setGroup(group: group[indexPath.row])
        return listcell
    }
}

extension GroupPlanController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let secondController = ExercisesPlanController()
        secondController.groupID = group[indexPath.row].id ?? ""
        secondController.groupName = group[indexPath.row].group
        secondController.planID = self.planID
        self.navigationController?.pushViewController(secondController, animated: true)
    }
}

extension GroupPlanController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}

