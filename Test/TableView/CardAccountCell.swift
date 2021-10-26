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
    private let leftImageView: CardImageView = {
        let imageView = CardImageView()
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    private let cardDetails: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 18
        return stackView
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .right
        return label
    }()
    
    private let showButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow-down"), for: .normal)
        button.setImage(UIImage(named: "arrow-up"), for: .selected)
        button.setTitle("Показать все", for: .normal)
        button.setTitle("Скрыть", for: .selected)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    
    private let cardsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
    
    var isShow = true
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUI() {
        contentView.addSubview(leftImageView)
        leftImageView.configure(with: .init(imageName: "tenge-icon", type: .block))
        leftImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
            make.size.equalTo(44)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(leftImageView.snp.right).offset(12)
            make.height.equalTo(20)
        }
        
        let one = some(with: "account-icon", text: "x 342434")
        let two = some(with: "card-icon", text: "x 32454")
        
        cardDetails.addArrangedSubview(one)
        cardDetails.addArrangedSubview(two)
        
        contentView.addSubview(cardDetails)
        cardDetails.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(titleLabel)
            make.width.greaterThanOrEqualTo(100)
            make.height.equalTo(17)
        }
        
        contentView.addSubview(amountLabel)
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(20)
        }
        
        contentView.addSubview(cardsStackView)
        cardsStackView.snp.makeConstraints { make in
            make.top.equalTo(cardDetails.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
        }
        
        contentView.addSubview(showButton)
        showButton.addTarget(self, action: #selector(didTapOnButton), for: .touchUpInside)
        showButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-16)
            make.width.greaterThanOrEqualTo(80)
        }
    }
    
    func configure() {
        titleLabel.text = "KZ12••2070"
        amountLabel.text = "12 900,00 $"
    }
    
    @objc func didTapOnButton() {
        delegate?.didTapOnButton(with: self)
        //        addCards()
        
        showButton.isSelected.toggle()
        isShow.toggle()
    }
    
    func addCards() {
        if isShow {
            addStackView()
            addStackView()
            cardsStackView.snp.updateConstraints { make in
                make.top.equalTo(cardDetails.snp.bottom)
                make.bottom.equalToSuperview().offset(-47)
            }
        } else {
            cardsStackView.subviews.forEach { $0.removeFromSuperview() }
            cardsStackView.snp.updateConstraints { make in
                make.top.equalTo(cardDetails.snp.bottom).offset(8)
                make.bottom.equalToSuperview().offset(-30)
            }
        }
        updateConstraints()
    }
    
    
    func addStackView() {
        let cardView = CardCell()
        cardView.configure()
        let line = lineView()
        line.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        cardsStackView.addArrangedSubview(line)
        cardsStackView.addArrangedSubview(cardView.contentView)
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
    
    func lineView() -> UIView {
        let mainLine = UIView()
        let line = UIView()
        line.backgroundColor = .blue
        line.frame = CGRect(x: 36, y: 0, width: 1, height: 20)
        mainLine.addSubview(line)
        return mainLine
    }
}
