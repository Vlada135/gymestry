//
//  DirectoryCell.swift
//  Gymestry
//
//  Created by Владислава on 12.09.23.
//

import UIKit
import SnapKit

class DirectoryCell: UICollectionViewCell {
    static let id = String(describing: DirectoryCell.self)
    
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.systemMint.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    lazy var picture:UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.alpha = 0.6
        label.isUserInteractionEnabled = true
        return label
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
    }
    
    private func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        picture.snp.makeConstraints{ make in
            make.leading.equalTo(mainView.snp.leading).offset(0)
            make.trailing.equalTo(mainView.snp.trailing).offset(0)
            make.top.equalTo(mainView.snp.top).offset(0)
            make.bottom.equalTo(mainView.snp.bottom).offset(-0)
        }
        
        nameLabel.snp.makeConstraints{ make in
            make.leading.equalTo(mainView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(mainView.snp.top).offset(10)
        }
    }
    
    private func initCell() {
        makeLayout()
        makeConstraints()
    }
    
    func set(point: Directory) {
        nameLabel.text = point.title
    }
    
}
