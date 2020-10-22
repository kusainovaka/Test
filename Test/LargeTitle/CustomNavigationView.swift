//
//  CustomNavigationView.swift
//  Test
//
//  Created by Kamila Kussainova on 10/22/20.
//  Copyright © 2020 Kamila Kusainova. All rights reserved.
//

import UIKit


protocol CustomNavBarDelegate: class {
    func didMove(type: NavBarState)
}

class CustomNavBar {
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.layer.cornerRadius = Const.ImageSizeForLargeState / 2
        button.clipsToBounds = true
        return button
    }()
    
    private let titleLabel = UILabel()
    private let titleText: String
    private let navBar: UINavigationController
    
    weak var delegate: CustomNavBarDelegate?
    
    init(title: String, navBar: UINavigationController) {
        self.titleText = title
        self.navBar = navBar
        
        navBar.navigationBar.prefersLargeTitles = true
        imageAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func imageAnimation() {
        navBar.navigationBar.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-52)
            make.bottom.equalToSuperview().offset(-Const.ImageBottomMarginForLargeState)
            make.size.equalTo(Const.ImageSizeForLargeState)
        }
    }
    
    private func titleAnimation() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.text = titleText
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        navBar.navigationBar.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            //            let iPhone5 = 20 ? 60
            make.right.equalTo(addButton.snp.left).offset(-20)
            make.bottom.equalToSuperview()
        }
    }
    
    func test(with height: CGFloat) {
        if height > 80 {
            setupTitle(type: .show)
        } else if height < 74 {
            if height < 56 {
                setupTitle(type: .hidden)
            } else {
                setupTitle(type: .none)
            }
        }
        
        moveAndResizeImage(for: height)
    }
    
    
    func some() {
        
    }
    
    private func moveAndResizeImage(for height: CGFloat) {
        let coeff: CGFloat = {
            let delta = height - Const.NavBarHeightSmallState
            let heightDifferenceBetweenStates = (Const.NavBarHeightLargeState - Const.NavBarHeightSmallState)
            return delta / heightDifferenceBetweenStates
        }()
        
        let factor = Const.ImageSizeForSmallState / Const.ImageSizeForLargeState
        
        let scale: CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()
        
        // Value of difference between icons for large and small states
        let sizeDiff = Const.ImageSizeForLargeState * (1.0 - factor) // 8.0
        let test = Const.ImageSizeForLargeState * (2.0 - factor) // 8.0
        
        let yTranslation: CGFloat = {
            /// This value = 14. It equals to difference of 12 and 6 (bottom margin for large and small states). Also it adds 8.0 (size difference when the image gets smaller size)
            let maxYTranslation = Const.ImageBottomMarginForLargeState - Const.ImageBottomMarginForSmallState + sizeDiff
            return max(0, min(maxYTranslation, (maxYTranslation - coeff * (Const.ImageBottomMarginForSmallState + sizeDiff))))
        }()
        
        let xTranslation = max(0, test - coeff * test)
        
        addButton.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
    }
    
    private func setupTitle(type: NavBarState) {
        delegate?.didMove(type: type)
        switch type {
            case .hidden:
                navBar.navigationItem.title = titleText
                titleLabel.isHidden = true
            case .show:
                navBar.navigationItem.title = ""
                titleAnimation()
                titleLabel.isHidden = false
            case .none:
                navBar.navigationItem.title = ""
                titleLabel.isHidden = true
        }
    }
}
