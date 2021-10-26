//
//  CardImageView.swift
//  Test
//
//  Created by Kamila Kussainova on 15.02.2021.
//  Copyright © 2021 Kamila Kusainova. All rights reserved.
//

import UIKit
// ImageWithStatusType
enum CardType {
    case normal
    case error
    case block
    case cancel
    case expired
    
    var imageName: String {
        switch self {
            case .normal:
                return ""
            default:
                return "block icon"
        }
    }
}

// ImageWithStatusModel
struct CardImageViewModel {
    let imageName: String
    let type: CardType
}
//ImageWithStatus
class CardImageView: UIView {
    private let cardImage = UIImageView()
    private let statusImage = UIImageView()
    
    init() {
        super.init(frame: .zero)
        
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUI() {
        addSubview(cardImage)
        cardImage.layer.borderWidth = 1
        cardImage.layer.cornerRadius = 12
        
        cardImage.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(8)
            make.right.bottom.equalToSuperview()
        }
        
        addSubview(statusImage)
        statusImage.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.size.equalTo(16)
        }
    }
    
    func configure(with model: CardImageViewModel) {
        cardImage.image = UIImage(named: model.imageName)
        statusImage.image = UIImage(named: model.type.imageName)
        
        switch model.type {
            case .normal:
                cardImage.layer.borderColor = UIColor.clear.cgColor
            default:
                cardImage.layer.borderColor = UIColor(red: 255/255, green: 87/255, blue: 33/255, alpha: 1).cgColor
        }
    }
}
