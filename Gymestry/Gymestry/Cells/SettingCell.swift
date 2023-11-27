//
//  SettingCell.swift
//  Gymestry
//
//  Created by Владислава on 12.11.23.
//

import UIKit
import SnapKit

class SettingCell: UICollectionViewCell {
    static let id = String(describing: SettingCell.self)
    
    private lazy var mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var circleView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.tintColor = .gray
        image.image = UIImage(systemName: "circle.fill")
        image.alpha = 0.7
        return image
     }()
    
    lazy var picture:UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.tintColor = .black
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var transitionView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        view.tintColor = .black
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
        mainView.addSubview(circleView)
        mainView.addSubview(picture)
        mainView.addSubview(nameLabel)
        mainView.addSubview(transitionView)
    }
    
    private func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        circleView.snp.makeConstraints{ make in
            make.leading.equalTo(mainView.snp.leading).offset(0)
            make.centerY.equalTo(mainView)
            make.height.width.equalTo(55)
        }
        picture.snp.makeConstraints{ make in
            make.center.equalTo(circleView)
            make.height.width.equalTo(20)
        }
        nameLabel.snp.makeConstraints{ make in
            make.leading.equalTo(circleView.snp.trailing).offset(20)
            make.trailing.equalTo(mainView.snp.trailing).offset(-10)
            make.height.equalTo(14)
            make.centerY.equalTo(mainView)
        }
        transitionView.snp.makeConstraints{ make in
            make.trailing.equalTo(mainView.snp.trailing).offset(-10)
            make.height.width.equalTo(18)
            make.centerY.equalTo(mainView)
        }
    }
    private func initCell() {
        makeLayout()
        makeConstraints()
    }
    func set(point: Settings) {
        nameLabel.text = point.title
        picture.image = point.image
    }
}
