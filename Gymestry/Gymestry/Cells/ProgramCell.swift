//
//  ProgramCell.swift
//  Gymestry
//
//  Created by Владислава on 25.11.23.
//

import UIKit
import SnapKit
import FirebaseAuth
import FirebaseDatabase

class ProgramCell: UITableViewCell {
    static let id = String(describing: ProgramCell.self)
    
    var list: PlanExercise?
    
    private lazy var mainView: UIView = {
        let view = UIView()
        return view
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
        mainView.addSubview(nameLabel)
        mainView.addSubview(transitionView)
    }
    
    private func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(10)
        }
        nameLabel.snp.makeConstraints{make in
            make.trailing.leading.equalTo(mainView).inset(-10)
            make.centerY.equalTo(mainView)
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
    }
    
    private func configure() {
        guard let list else { return }
        nameLabel.text = list.name
    }
    
    func setPlan(list: PlanExercise) {
        self.list = list
        configure()
    }
}

