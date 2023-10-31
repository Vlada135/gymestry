//
//  SporteatCell.swift
//  Gymestry
//
//  Created by Владислава on 18.09.23.
//

import UIKit
import SnapKit

class SporteatCell: UICollectionViewCell {
    static let id = String(describing: SporteatCell.self)
    
    private lazy var mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var picture:UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var transitionView: UIImageView = {
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
        //        mainView.addSubview(picture)
        mainView.addSubview(nameLabel)
        mainView.addSubview(transitionView)
    }
    
    private func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        //        picture.snp.makeConstraints{ make in
        //            make.leading.equalTo(mainView.snp.leading).offset(0)
        //            make.trailing.equalTo(mainView.snp.trailing).offset(0)
        //            make.top.equalTo(mainView.snp.top).offset(0)
        //            make.bottom.equalTo(mainView.snp.bottom).offset(-0)
        //        }
        nameLabel.snp.makeConstraints{ make in
            make.leading.equalTo(mainView.snp.leading).offset(10)
            make.trailing.equalTo(mainView.snp.trailing).offset(-10)
            make.top.equalTo(mainView.snp.top).offset(10)
            make.height.equalTo(20)
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
    }
    func set(point: SporteatModel) {
        nameLabel.text = point.title
    }
}
