//
//  ExercisesDetails.swift
//  Gymestry
//
//  Created by Владислава on 25.11.23.
//

import Foundation
import SnapKit
import UIKit
import Gifu

class ExercisesDetails: UIViewController {
    
    var exercises: [Exercises] = []
    
    var exerciseid: String = ""
    
    private lazy var imageGIF: GIFImageView = {
        let image = GIFImageView()
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.isUserInteractionEnabled = true
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var infoText: UITextView = {
        let view = UITextView()
        view.textColor = .black
        view.isEditable = false
        view.font = .systemFont(ofSize: 15, weight: .thin)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        makeConstraints()
        readList()
    }
    
    private func makeLayout() {
        view.backgroundColor = .white
        view.addSubview(imageGIF)
        view.addSubview(nameLabel)
        view.addSubview(infoText)
    }
    
    private func makeConstraints() {
        imageGIF.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(270)
        }
        nameLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(imageGIF.snp.bottom).offset(10)
        }
        infoText.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-100)
        }
    }
    
    private func parseData(_ dict: [String : Any]) {
        exercises.removeAll()
        for (key, value) in dict {
            guard let answer = value as? [String: Any] else { continue }
            guard let new = try? Exercises(
                key: key,
                dict: answer
            ) else { continue }
            if new.id == self.exerciseid {
                self.exercises.append(new)
                self.exercises.sort(by: {$0.id ?? "" > $1.id ?? ""})
                
                self.nameLabel.text = new.exercise
                self.infoText.text = new.instruction?.replacingOccurrences(of: "[br]", with: "\n\n")
                
                DispatchQueue.global().async { [weak self] in
                    guard let self,
                          let url = URL(string: new.exerciseGIF ?? "")
                    else { return }
                    print("1")
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        print("2")
                        self.imageGIF.animate(withGIFURL: url)
                    }
                }
            }
        }
    }
    
    private func readList() {
        Environment.ref.child("exercises").observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let contactsDict = (snapshot.value as? [String: Any]) else { return }
            self?.parseData(contactsDict)
        }
    }
    
    func set(list: Exercises) {
        self.nameLabel.text = list.exercise
        self.infoText.text = list.instruction?.replacingOccurrences(of: "[br]", with: "\n\n")
        
        DispatchQueue.global().async { [weak self] in
            guard let self,
                  let url = URL(string: list.exerciseGIF ?? "")
            else { return }
            print("1")
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                print("2")
                self.imageGIF.animate(withGIFURL: url)
            }
        }
    }
}
