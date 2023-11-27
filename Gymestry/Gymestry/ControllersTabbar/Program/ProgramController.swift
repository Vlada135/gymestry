//
//  ProgramController.swift
//  Gymestry
//
//  Created by Владислава on 1.10.23.
//

import Foundation
import UIKit
import SnapKit
import FirebaseAuth
import FirebaseDatabase

class ProgramController: UIViewController {
    
    var planExercise: [PlanExercise] = []
    
    private lazy var createProgramButton: GradientButton = {
        let button = GradientButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.startColor = UIColor.black
        button.endColor = UIColor.gray
        button.setTitle(
            " Добавить новую программу",
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(addProgram),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(ProgramCell.self, forCellReuseIdentifier: ProgramCell.id)
        return table
    }()
    
    
    private let mode: ControllerMode
    
    init(mode: ControllerMode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        makeConstraints()
    }
    
    private func makeLayout() {
        view.backgroundColor = .white
        title = "Программа"
        view.addSubview(tableView)
        view.addSubview(createProgramButton)
    }
    
    private func makeConstraints() {
        createProgramButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(21)
            make.height.equalTo(45)
        }
        tableView.snp.makeConstraints { make in
            make.bottom.equalTo(createProgramButton.snp.top).inset(-30)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(21)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(25)
        }
    }
    
    private func parseData(_ dict: [String : Any]) {
        planExercise.removeAll()
        for (key, value) in dict {
            guard let answer = value as? [String: Any] else { continue }
            guard let new = try? PlanExercise(
                key: key,
                dict: answer
            ) else { continue }
            self.planExercise.append(new)
            self.planExercise.sort(by: {$0.id ?? "" > $1.id ?? ""})
            
        }
        self.tableView.reloadData()
    }
    
    private func readList() {
        guard let user = Auth.auth().currentUser else { return }
        Environment.ref.child("users/\(user.uid)/plans").observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let contactsDict = (snapshot.value as? [String: Any]) else { return }
            self?.parseData(contactsDict)
        }
    }
    
    @objc private func addProgram() {
        let secondController = AddProgrammController(mode: .create)
        guard
            let user = Auth.auth().currentUser,
            let autoId = Environment.ref.child("users/\(user.uid)/plans/").childByAutoId().key
        else { return }
        
        let planList = PlanExercise(
            id: autoId,
            name: nil
        )
        
        switch mode {
        case .create:
            Environment.ref.child("users/\(user.uid)/plans/\(planList.id ?? "")").setValue(planList.asDict)
        case .edit(let editable):
            guard let id = editable.id else { return }
            Environment.ref.child("users/\(user.uid)/plans/\(id)").updateChildValues(planList.asDict)
        }
        
        secondController.planID = planList.id ?? ""
        self.navigationController?.pushViewController(secondController, animated: true)
    }
}

extension ProgramController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planExercise.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProgramCell.self), for: indexPath) as? ProgramCell else { return .init() }
        cell.setPlan(list: planExercise[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let user = Auth.auth().currentUser else { return }
            Environment.ref.child("users/\(user.uid)/plans/\(planExercise[indexPath.row].id ?? "")").removeValue()
            planExercise.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}

extension ProgramController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let secondController = AddProgrammController(mode: .create)
        secondController.planID = planExercise[indexPath.row].id ?? ""
        secondController.planName = planExercise[indexPath.row].name ?? ""
        self.navigationController?.pushViewController(secondController, animated: true)
    }
}
