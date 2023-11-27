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
        label.textColor = .white
        label.isUserInteractionEnabled = true
        return label
    }()
    
   private lazy var gradientView: UIView = {
        let view = Gradient()
        view.startColor = UIColor.black
        view.endColor = nil
        view.horizontalMode = true
        view.alpha = 1
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
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
        mainView.addSubview(gradientView)
        mainView.addSubview(nameLabel)
    }
    
    private func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(10)
        }
        picture.snp.makeConstraints{ make in
            make.edges.equalTo(mainView)
        }
        gradientView.snp.makeConstraints{ make in
            make.edges.equalTo(mainView)
        }
        nameLabel.snp.makeConstraints{ make in
            make.leading.equalTo(mainView.snp.leading).offset(10)
            make.trailing.equalTo(mainView.snp.trailing).offset(-10)
            make.top.equalTo(mainView.snp.top).offset(10)
            make.height.equalTo(20)
            make.centerY.equalTo(mainView.snp.centerY)
        }
    }
    
    private func initCell() {
        makeLayout()
        makeConstraints()
    }
    
    func set(point: Directory) {
        nameLabel.text = point.title
        picture.image = point.image
    }
}
