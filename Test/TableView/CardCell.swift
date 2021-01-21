//
//  CardCell.swift
//  Test
//
//  Created by Kamila Kussainova on 20.01.2021.
//  Copyright © 2021 Kamila Kusainova. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {
    
    private let leftImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "tenge")
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    private let subTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .right
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .green
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUI() {
        contentView.addSubview(leftImageView)
        leftImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
            make.size.equalTo(36)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(leftImageView)
            make.left.equalTo(leftImageView.snp.right).offset(12)
            make.height.equalTo(20).priority(.low)
        }
        let card = some(with: "world-icon", text: "••0001")
        
        contentView.addSubview(card)
        card.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        contentView.addSubview(amountLabel)
        amountLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(20)
        }
    }
    
    func configure() {
        titleLabel.text = "ARTYOM BOSS"
        subTitle.text = "**** 1235"
        amountLabel.text = "300 720,00 ₸ "
    }
    
    func some(with imageName: String, text: String) -> UIView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        let image = UIImageView(image: UIImage(named: imageName))
        image.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(image)
        image.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(16)
        }
        
        let title = UILabel()
        title.text = text
        title.textColor = .lightGray
        title.font = UIFont.systemFont(ofSize: 13)
        stackView.addArrangedSubview(title)
        return stackView
    }
}
