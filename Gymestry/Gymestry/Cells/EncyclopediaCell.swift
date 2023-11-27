//
//  EncyclopediaCell.swift
//  Gymestry
//
//  Created by Владислава on 24.11.23.
//

import UIKit
import SnapKit

class EncyclopediaCell: UICollectionViewCell {
    static let id = String(describing: EncyclopediaCell.self)
    
    var list: Encyclopedia?
    
    
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
        label.numberOfLines = 0
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
            make.leading.trailing.equalTo(mainView).inset(10)
            make.top.equalTo(mainView.snp.top).offset(10)
            make.height.equalTo(20)
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
        nameLabel.text = list.title
        
        DispatchQueue.global().async { [weak self] in
            guard let self,
                  let url = URL(string: list.encyclopediaImage),
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.picture.image = image
            }
        }
    }
    
    func setEncyclopedia(encyclopedia: Encyclopedia) {
        self.list = encyclopedia
        configure()
    }
}
