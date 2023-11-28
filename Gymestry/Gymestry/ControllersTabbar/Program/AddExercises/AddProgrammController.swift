//
//  AddProgrammController.swift
//  Gymestry
//
//  Created by Владислава on 20.11.23.
//

import Foundation
import UIKit
import SnapKit
import FirebaseAuth
import FirebaseDatabase

class AddProgrammController: UIViewController {
    
    var exercisesAdd: [ExerciseAdd] = []
    var planName: String = ""
    var exerciseName: String = ""
    var exerciseID: String = ""
    var durationCondition: Bool = true
    var weightCondition: Bool = true
    var numberCondition: Bool = true
    
    var planID: String = ""
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        button.tintColor = .black
        button.setTitle(
            "Сохранить",
            for: .normal
        )
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        return button
    }()
    
    private lazy var inputNameProgram: InputLabField = {
        let field = InputLabField(placeholder: "Введите название программы", textLabel: "Название")
        return field
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(ExerciseProgramCell.self, forCellReuseIdentifier: ExerciseProgramCell.id)
        return table
    }()
    
    private lazy var addExeciseButton: GradientButton = {
        let button = GradientButton(type: .system)
        button.tintColor = .white
        button.startColor = UIColor.black
        button.endColor = UIColor.gray
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.setTitle(
            " Добавить упражнение",
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(addExercise),
            for: .touchUpInside
        )
        return button
    }()
    
    private let mode: ControllerMode
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        makeConstraints()
    }
    
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
    
    private func makeLayout() {
        view.backgroundColor = .white
        view.addSubview(saveButton)
        view.addSubview(inputNameProgram)
        view.addSubview(tableView)
        view.addSubview(addExeciseButton)
    }
    
    private func makeConstraints() {
        inputNameProgram.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(80)
        }
        tableView.snp.makeConstraints { make in
            make.bottom.equalTo(addExeciseButton.snp.top).inset(-10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(21)
            make.top.equalTo(inputNameProgram.snp.bottom).offset(20)
        }
        addExeciseButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(21)
            make.height.equalTo(45)
        }
    }
    
    private func parseData(_ dict: [String : Any]) {
        exercisesAdd.removeAll()
        for (key, value) in dict {
            guard let answer = value as? [String: Any] else { continue }
            guard let new = try? ExerciseAdd(
                key: key,
                dict: answer
            ) else { continue }
            self.exercisesAdd.append(new)
            self.exercisesAdd.sort(by: {$0.id ?? "" < $1.id ?? ""})
            
            inputNameProgram.text = self.planName
    
        }
        self.tableView.reloadData()
    }
    
    private func readList() {
        guard let user = Auth.auth().currentUser else { return }
        Environment.ref.child("users/\(user.uid)/plans/\(planID)/exercises").observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let contactsDict = (snapshot.value as? [String: Any]) else { return }
            self?.parseData(contactsDict)
        }
    }
    
    @objc private func addExercise(){
        let secondController = GroupPlanController()
        secondController.planID = planID
        self.navigationController?.pushViewController(secondController, animated: true)
    }
    
    @objc private func saveAction(){
        guard let name = inputNameProgram.text,
              let user = Auth.auth().currentUser
        else { return }
        
        
        let planList = PlanExercise(
            name: name
        )
        
        switch mode {
        case .create:
            Environment.ref.child("users/\(user.uid)/plans/\(planID)/name").setValue(name)
        case .edit(let editable):
            guard let id = editable.id else { return }
            Environment.ref.child("users/\(user.uid)/plans/\(id)").updateChildValues(planList.asDict)
        }
    }
    
}

extension AddProgrammController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercisesAdd.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ExerciseProgramCell.self), for: indexPath) as? ExerciseProgramCell else { return .init() }
        cell.setExercise(list: exercisesAdd[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let user = Auth.auth().currentUser else { return }
            Environment.ref.child("users/\(user.uid)/plans/\(planID)/exercises/\(exercisesAdd[indexPath.row].id ?? "")").removeValue()
            exercisesAdd.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}

extension AddProgrammController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondController = ExercisesDetails()
        secondController.exerciseid = exercisesAdd[indexPath.row].exerciseID
        self.navigationController?.pushViewController(secondController, animated: true)
    }
}





