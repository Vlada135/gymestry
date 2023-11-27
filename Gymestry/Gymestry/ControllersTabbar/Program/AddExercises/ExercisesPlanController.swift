//
//  ExercisesPlanController.swift
//  Gymestry
//
//  Created by Владислава on 20.11.23.
//

import Foundation
import SnapKit
import UIKit
import FirebaseAuth
import FirebaseDatabase

class ExercisesPlanController: UIViewController {
    var exerciseAdd: [ExerciseAdd] = []
    var exercises: [Exercises] = []
    var groupID: String = ""
    var groupName: String = ""
    var planID: String = ""
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readList()
    }
    private func makeLayout() {
        view.backgroundColor = .white
        title = groupName
        view.addSubview(collectionView)
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
        let secondController = ExercisesAdd(mode: .create)
        secondController.groupIDAdd = self.groupID
        self.navigationController?.pushViewController(secondController, animated: true)
    }
    private func parseData(_ dict: [String : Any]) {
        exercises.removeAll()
        for (key, value) in dict {
            guard let answer = value as? [String: Any] else { continue }
            guard let new = try? Exercises(
                key: key,
                dict: answer
            ) else { continue }
            if new.idGroup == self.groupID {
                self.exercises.append(new)
                self.exercises.sort(by: {$0.id ?? "" > $1.id ?? ""})
            }
        }
        self.collectionView.reloadData()
    }
    
    private func readList() {
        Environment.ref.child("exercises").observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let contactsDict = (snapshot.value as? [String: Any]) else { return }
            self?.parseData(contactsDict)
        }
        
    }
}

extension ExercisesPlanController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exercises.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExercisesCell.id, for: indexPath)
        guard let listcell = cell as? ExercisesCell else { return .init() }
        listcell.setGroup(exercise: exercises[indexPath.row])
        return listcell
    }
}

extension ExercisesPlanController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let secondController = AddProgrammController(mode: .create)
        secondController.exerciseID = exercises[indexPath.row].id ?? ""
        secondController.exerciseName = exercises[indexPath.row].exercise
        secondController.weightCondition = exercises[indexPath.row].weightSelect
        secondController.durationCondition = exercises[indexPath.row].durationSelect
        secondController.numberCondition = exercises[indexPath.row].numberSelect
        
        guard
            let image  = exercises[indexPath.row].exerciseImage,
            let user = Auth.auth().currentUser,
            let exerciseID = exercises[indexPath.row].id,
            let autoId = Environment.ref.child("users/\(user.uid)/plans/\(planID)/exercisesUser").childByAutoId().key
        else { return }
        
        let name = exercises[indexPath.row].exercise
        
        let planList = ExerciseAdd(
            id: autoId,
            name: name,
            exerciseID: exerciseID,
            exerciseImage: image
        )
        
        Environment.ref.child("users/\(user.uid)/plans/\(planID)/exercises/\(planList.id ?? "")").setValue(planList.asDict)
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers ;
        for aViewController in viewControllers {
            if(aViewController is AddProgrammController){
                self.navigationController!.popToViewController(aViewController, animated: true);
            }
        }
    }
}

extension ExercisesPlanController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}
