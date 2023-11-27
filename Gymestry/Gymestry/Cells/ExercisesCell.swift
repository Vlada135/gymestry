//
//  ExercisesCell.swift
//  Gymestry
//
//  Created by Владислава on 25.09.23.
//

import UIKit
import SnapKit
import FirebaseAuth
import FirebaseDatabase

class ExercisesCell: UICollectionViewCell {
    static let id = String(describing: ExercisesCell.self)
    
    var list: Exercises?
    
    private lazy var mainView: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var activityIndicator:UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.startAnimating()
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
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
        self.picture.image = UIImage(named: "activity")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.picture.image = UIImage(named: "activity")
    }
    
    private func configure() {
        guard let list else { return }
        nameLabel.text = list.exercise
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
    
    func setGroup(exercise: Exercises) {
        self.list = exercise
        configure()
    }
}

