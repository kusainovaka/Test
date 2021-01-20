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
        imageView.backgroundColor = .red
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
            make.top.equalToSuperview().offset(15)
            make.left.equalTo(leftImageView.snp.right).offset(12)
            make.height.equalTo(20).priority(.low)
        }
        contentView.addSubview(subTitle)
        subTitle.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
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
        titleLabel.text = "CardCell"
        subTitle.text = "**** 1235"
        amountLabel.text = "$$$$$$"
    }
}
