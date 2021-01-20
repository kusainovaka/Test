//
//  CardAccountCell.swift
//  Test
//
//  Created by Kamila Kussainova on 20.01.2021.
//  Copyright © 2021 Kamila Kusainova. All rights reserved.
//

import UIKit

protocol CardAccountCellDelegate: class {
    func didTapOnButton(with cell: CardAccountCell)
}

class CardAccountCell: UITableViewCell {
    
    weak var delegate: CardAccountCellDelegate?
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
    
    private let cardDetails: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .right
        return label
    }()
    
    private let showButton: UIButton = {
        let button = UIButton()
        button.setTitle("Показать все", for: .normal)
        button.setTitle("Скрыть", for: .selected)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    var isShow = true
    
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
            make.height.equalTo(20)
        }
        
        contentView.addSubview(cardDetails)
        cardDetails.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(titleLabel)
            make.width.greaterThanOrEqualTo(100)
            make.height.equalTo(17)
        }
        
        contentView.addSubview(amountLabel)
        amountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(20)
        }
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(cardDetails.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        
        contentView.addSubview(showButton)
        showButton.addTarget(self, action: #selector(didTapOnButton), for: .touchUpInside)
        showButton.snp.makeConstraints { make in
//            make.top.equalTo(stackView.snp.bottom).offset(15)
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-16)
            make.width.greaterThanOrEqualTo(80)
        }
    }
    
    func configure() {
        titleLabel.text = "CardAccountCell"
        amountLabel.text = "$$$$$$"
    }
    
    @objc func didTapOnButton() {
        delegate?.didTapOnButton(with: self)
        showButton.isSelected.toggle()
        isShow.toggle()
    }
    
    func addCards() {
        if isShow {
            let cardView = CardCell()
            cardView.configure()
            stackView.addArrangedSubview(cardView.contentView)
        } else {
            stackView.subviews.forEach { $0.removeFromSuperview() }
        }
    }
}
