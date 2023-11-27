//
//  ProfileController.swift
//  Gymestry
//
//  Created by Владислава on 1.10.23.
//

import Foundation
import UIKit
import SnapKit
import PhotosUI
import FirebaseAuth
import Charts

class ProfileController: UIViewController {
    
    var person: PersonData?
    var weights = [Weights]()
    weak var axisFormatDelegate: AxisValueFormatter?
    
    private lazy var barChartView: LineChartView = {
        let chart = LineChartView()
        chart.animate(yAxisDuration: 1.0)
        chart.pinchZoomEnabled = false
        chart.drawBordersEnabled = false
        chart.doubleTapToZoomEnabled = false
        chart.drawGridBackgroundEnabled = true
        return chart
    }()
    
    private lazy var settingButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(settingAction), for: .touchUpInside)
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        button.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        return button
    }()
    
    private lazy var profileView = InputView()
    private lazy var weightView = InputView()
    
    private lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 50
        image.layer.borderWidth = 1
        image.contentMode = .scaleAspectFill
        image.layer.borderColor = UIColor.clear.cgColor
        image.image = UIImage(systemName: "person.crop.circle.fill")
        image.tintColor = .gray
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var infoView: UIView = {
        let view = UIView()
        view.clipsToBounds = false
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .gray
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 5
        return view
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.spacing = 5
        stack.axis = .vertical
        stack.clipsToBounds = false
        stack.layer.cornerRadius = 12
        stack.layer.borderColor = UIColor.clear.cgColor
        stack.layer.borderWidth = 1
        stack.backgroundColor = .systemGray5
        stack.layer.shadowOpacity = 0.4
        stack.layer.shadowOffset = CGSize(width: 0, height: 0)
        stack.layer.shadowRadius = 3
        return stack
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .heavy)
        label.textColor = .black
        label.isUserInteractionEnabled = true
        label.textAlignment = .left
        return label
    }()
    
    private lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkGray
        label.isUserInteractionEnabled = true
        label.textAlignment = .left
        return label
    }()
    
    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkGray
        label.isUserInteractionEnabled = true
        label.textAlignment = .left
        return label
    }()
    
    private lazy var stackForPicker: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    private lazy var pickerLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "Выберете дату:"
        return label
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .compact
        picker.contentHorizontalAlignment = .center
        return picker
    }()
    
    private lazy var saveWeightButton: GradientButton = {
        let button = GradientButton(type: .system)
        button.tintColor = .white
        button.startColor = UIColor.black
        button.endColor = UIColor.gray
        button.setTitle(
            "Сохранить",
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(addWeight),
            for: .touchUpInside
        )
        return button
    }()
    private lazy var inputField: UITextField = {
        let field = UITextField()
        field.textAlignment = .left
        field.layer.cornerRadius = 14
        field.backgroundColor = .systemGray5
        field.placeholder = "Ведите Ваш вес"
        field.textAlignment = .center
        return field
    }()
    
    private lazy var inputLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.isUserInteractionEnabled = true
        label.textAlignment = .center
        label.text = "Вес"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readUserData()
        makeLayout()
        makeConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readList()
    }
 
    
    private func makeLayout() {
        view.backgroundColor = .white
        title = "Профиль"
        view.addSubview(settingButton)
        view.addSubview(profileView)
        view.addSubview(weightView)
        weightView.addSubview(inputLabel)
        weightView.addSubview(inputField)
        weightView.addSubview(stackForPicker)
        weightView.addSubview(saveWeightButton)
        stackForPicker.addArrangedSubview(pickerLabel)
        stackForPicker.addArrangedSubview(datePicker)
        view.addSubview(barChartView)
        profileView.addSubview(avatarImageView)
        profileView.addSubview(nameLabel)
        profileView.addSubview(stack)
        stack.addArrangedSubview(heightLabel)
        stack.addArrangedSubview(weightLabel)
    }
    
    private func makeConstraints() {
        
        profileView.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
        }
        avatarImageView.snp.makeConstraints{ make in
            make.trailing.equalTo(profileView.snp.trailing).offset(-20)
            make.height.width.equalTo(100)
            make.centerY.equalTo(profileView)
        }
        nameLabel.snp.makeConstraints{ make in
            make.leading.equalTo(profileView.snp.leading).offset(50)
            make.trailing.equalTo(avatarImageView.snp.leading).offset(-20)
            make.top.equalTo(profileView.snp.top).offset(26)
            make.height.equalTo(30)
        }
        stack.snp.makeConstraints{ make in
            make.leading.equalTo(profileView.snp.leading).offset(45)
            make.trailing.equalTo(avatarImageView.snp.leading).offset(-80)
            make.height.equalTo(60)
            make.bottom.equalTo(profileView.snp.bottom).offset(-26)
        }
        barChartView.snp.makeConstraints{ make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(weightView.snp.top).offset(-20)
            make.top.equalTo(profileView.snp.bottom).offset(20)
        }
        weightView.snp.makeConstraints { make in
            make.height.equalTo(230)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-26)
        }
        inputLabel.snp.makeConstraints { make in
            make.top.equalTo(weightView.snp.top).offset(10)
            make.leading.trailing.equalTo(weightView).inset(10)
            make.centerX.equalToSuperview()
        }
        inputField.snp.makeConstraints { make in
            make.top.equalTo(inputLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(weightView).inset(105)
            make.height.equalTo(40)
            make.bottom.equalTo(stackForPicker.snp.top).offset(-10)
            make.centerX.equalToSuperview()
        }
        stackForPicker.snp.makeConstraints { make in
            make.bottom.equalTo(saveWeightButton.snp.top).offset(-10)
            make.leading.trailing.equalTo(weightView).inset(10)
            make.centerX.equalToSuperview()
        }
        saveWeightButton.snp.makeConstraints { make in
            make.bottom.equalTo(weightView.snp.bottom).offset(-20)
            make.leading.trailing.equalTo(weightView).inset(50)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
    }
    
    private func dateToString(format: String, date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let result = formatter.string(from: date)
        return result
    }
    
    @objc private func addWeight() {
        guard
            let weight = Double(inputField.text ?? "0"),
            let user = Auth.auth().currentUser
        else { return }
        
        let weightList = Weights(
            id: nil,
            weight: weight,
            date: datePicker.date
        )
        Environment.ref.child("users/\(user.uid)/weights").childByAutoId().setValue(weightList.asDict)
        inputField.text = ""
        readList()
    }
    
    @objc func settingAction() {
        let secondController = SettingController()
        self.navigationController?.pushViewController(secondController, animated: true)
    }
    
    private func readUserData() {
        guard let user = Auth.auth().currentUser else { return }
        let child = Environment.storage.child("images/\(user.uid).jpg")
        
        child.downloadURL { (url, error) in
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let url,
                      let data = try? Data(contentsOf: url),
                      let image = UIImage(data: data)
                else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.avatarImageView.image = image
                }
            }
        }
        
        Environment.ref.child("users/\(user.uid)/userData").observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let contactValue = snapshot.value as? [String: Any],
                  let contactForEdit = try? PersonData(key: user.uid, dict: contactValue)
            else { return }
            
            self?.nameLabel.text = contactForEdit.name
            self?.heightLabel.text =  "  Рост: \(contactForEdit.height ?? "") см"
            self?.weightLabel.text =  "  Возраст: \(contactForEdit.age ?? "")"
            
        }
    }
    
    private func readList() {
        guard let user = Auth.auth().currentUser else { return }
        
        Environment.ref.child("users/\(user.uid)/weights").observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let contactsDict = (snapshot.value as? [String: Any]) else { return }
            self?.parseData(contactsDict)
        }
    }
    
    func parseData(_ dict: [String : Any]) {
        weights.removeAll()
        for (key, value) in dict {
            guard let answer = value as? [String: Any] else { continue }
            guard let new = try? Weights(
                key: key,
                dict: answer
            ) else { continue }
            self.weights.append(new)
            self.weights.sort(by: {$0.date > $1.date})
        }
        
        axisFormatDelegate = self
        self.setChart()
    }
    
    private func setChart() {
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<weights.count {
            let timeIntervalForDate: TimeInterval = weights[i].date.timeIntervalSince1970
            let dataEntry = ChartDataEntry(x: timeIntervalForDate, y: Double(weights[i].weight))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "Вес")
        chartDataSet.mode = .linear
        chartDataSet.colors = [UIColor.systemPurple]
        chartDataSet.circleColors = [UIColor.systemPurple]
        let chartData = LineChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        
        let xAxisValue = barChartView.xAxis
        xAxisValue.granularityEnabled = true
        xAxisValue.granularity = 1
        xAxisValue.valueFormatter = axisFormatDelegate
        
        barChartView.xAxis.labelPosition = .bottom
    }
}

extension ProfileController: AxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "dd-MM"
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}
