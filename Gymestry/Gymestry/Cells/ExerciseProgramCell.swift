//
//  ExerciseProgramCell.swift
//  Gymestry
//
//  Created by Владислава on 21.11.23.
//

import UIKit
import SnapKit
import FirebaseAuth
import FirebaseDatabase

class ExerciseProgramCell: UITableViewCell {
    static let id = String(describing: ExerciseProgramCell.self)
    
    var list: ExerciseAdd?
    
    private lazy var mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var picture:UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
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
    
    private lazy var transitionView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeLayout() {
        contentView.backgroundColor = .white
        contentView.addSubview(mainView)
        mainView.addSubview(picture)
        mainView.addSubview(nameLabel)
        mainView.addSubview(transitionView)
    }
    
    private func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(10)
        }
        picture.snp.makeConstraints{ make in
            make.leading.equalTo(mainView.snp.leading)
            make.top.equalTo(mainView.snp.top)
            make.bottom.equalTo(mainView.snp.bottom)
            make.height.width.equalTo(90)
        }
        nameLabel.snp.makeConstraints{ make in
            make.leading.equalTo(picture.snp.trailing).offset(10)
            make.trailing.equalTo(transitionView.snp.leading).offset(-5)
            make.centerY.equalTo(mainView.snp.centerY)
        }
        transitionView.snp.makeConstraints{ make in
            make.trailing.equalTo(mainView.snp.trailing).offset(-10)
            make.height.width.equalTo(20)
            make.centerY.equalTo(mainView.snp.centerY)
        }
    }
    
    private func initCell() {
        makeLayout()
        makeConstraints()
        self.picture.image = UIImage(systemName: "gear")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.picture.image = UIImage(systemName: "gear")
    }
    
    private func configure() {
        guard let list else { return }
        nameLabel.text = list.name
        DispatchQueue.global().async { [weak self] in
            guard let self,
                  let url = URL(string: list.exerciseImage ?? ""),
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else { return }
            print("1")
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                print("2")
                self.picture.image = image
            }
        }
        
    }
    
    func setExercise(list: ExerciseAdd) {
        self.list = list
        configure()
    }
}


