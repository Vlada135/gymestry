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
    
    var list: Sporteat?
    
    private lazy var mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var picture:UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
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
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        picture.snp.makeConstraints{ make in
            make.leading.equalTo(mainView.snp.leading)
            make.top.equalTo(mainView.snp.top)
            make.bottom.equalTo(mainView.snp.bottom)
            make.height.width.equalTo(90)
        }
        nameLabel.snp.makeConstraints{ make in
            make.leading.equalTo(picture.snp.trailing).offset(10)
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
        self.picture.image = UIImage(systemName: "gear")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.picture.image = UIImage(systemName: "gear")
    }
    
    private func configure() {
        guard let list else { return }
        nameLabel.text = list.sporteat
        
        DispatchQueue.global().async { [weak self] in
            guard let self,
                  let url = URL(string: list.sporteatImage),
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.picture.image = image
            }
        }
    }
    
    func setSporteat(sporteat: Sporteat) {
        self.list = sporteat
        configure()
    }
}
