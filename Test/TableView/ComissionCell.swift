//
//  ComissionCell.swift
//  Test
//
//  Created by Kamila Kussainova on 11.01.2021.
//  Copyright © 2021 Kamila Kusainova. All rights reserved.
//

import UIKit

private enum Constants {
    static let hightPriority = UILayoutPriority(1000)
}

class PaymentComissionCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let comissionLabel = UILabel()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
//        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        stackView.alignment = .top
        return stackView
    }()
    
    private let infoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setImage(UIImage(named: "info"), for: .normal)
//        button.contentHorizontalAlignment = .leading
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
//        button.imageView?.contentMode = .le
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
//        backgroundColor = ColorPalette.Background.global
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        sta
//        titleLabel.text = nil
//        comissionLabel.text = nil
    }
    
    private func layoutUI() {
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(18)
            make.top.bottom.equalToSuperview()
        }
        
        titleLabel.setContentHuggingPriority(Constants.hightPriority, for: .horizontal)
        comissionLabel.setContentHuggingPriority(UILayoutPriority(1700), for: .horizontal)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(comissionLabel)
        stackView.addArrangedSubview(infoButton)
//        infoButton.snp_makeConstraints { make in
//            make.size.equalTo(22)
//        }
    }
    
    func configure(data: PaymentComissionCellModel) {
        titleLabel.text = data.title
        
        if let amount = data.amount {
            comissionLabel.text = amount
//            setComissionAttribute(amount: amount, currency: data.currency)
        } else {
            comissionLabel.textColor = UIColor.gray
            comissionLabel.text = data.emptyTitle
        }
    }
}

struct PaymentComissionCellModel: Hashable {
    let title: String
    var emptyTitle: String?
    var amount: String?
}
