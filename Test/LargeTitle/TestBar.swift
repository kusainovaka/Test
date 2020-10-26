//
//  TestBar.swift
//  Test
//
//  Created by Kamila Kussainova on 10/26/20.
//  Copyright © 2020 Kamila Kusainova. All rights reserved.
//

import UIKit

fileprivate enum Constants {
    // Button
    static let buttonSizeForLargeState: CGFloat = 48
    static let buttonSizeForSmallState: CGFloat = 32
    static let buttonBottomMarginForLargeState: CGFloat = 12
    static let buttonBottomMarginForSmallState: CGFloat = 6
    static let buttonRightOffset = 52
    // Navigation bar
    static let navBarHeightSmallState: CGFloat = 44
    static let navBarHeightLargeState: CGFloat = 96.5
    // Title
    static let titleSmallRightOffset = 20
    static let titleLargeRightOffset = buttonRightOffset + titleSmallRightOffset
    // Scroll
    static let scrollMaxHeight: CGFloat = 80
    static let scrollMinHeight: CGFloat = 56
}

class TestBar: UINavigationBar {
    
    weak var customDelegate: CustomNavigationBarDelegate?
    var customHeight : CGFloat = 126
    
    private lazy var actioButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.buttonSizeForLargeState / 2
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapOnActioButton), for: .touchUpInside)
        return button
    }()
    
    private let largeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private var isHasButton = false
    
    //    override func sizeThatFits(_ size: CGSize) -> CGSize {
    //        let newSize :CGSize = CGSize(width: self.frame.size.width, height: 126)
    //        return newSize
    //    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        self.isTranslucent = false
        self.barTintColor = .orange
        prefersLargeTitles = true
        setupTitle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(text: String) {
        largeTitleLabel.text = text
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: customHeight)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.tintColor = .black
        
        frame = CGRect(x: frame.origin.x, y:  0, width: frame.size.width, height: customHeight)
        
        // title position (statusbar height / 2)
        setTitleVerticalPositionAdjustment(-10, for: UIBarMetrics.default)
        
//        for subview in self.subviews {
//            var stringFromClass = NSStringFromClass(subview.classForCoder)
//            if stringFromClass.contains("BarBackground") {
//                subview.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: customHeight)
//                subview.backgroundColor = .yellow
//
//            }
//
//            stringFromClass = NSStringFromClass(subview.classForCoder)
//            if stringFromClass.contains("BarContent") {
//
//                subview.frame = CGRect(x: subview.frame.origin.x, y: 20, width: subview.frame.width, height: customHeight - 20)
//
//
//            }
//        }
    }
    
    //    override func layoutSubviews() {
    //        super.layoutSubviews()
    //        sizeToFit()
    ////        frame = CGRect(x: frame.origin.x, y:  0, width: frame.size.width, height: 126)
    //    }
        
    private func setupTitle() {
        largeTitleLabel.text = "Введите номер телефона"
        addSubview(largeTitleLabel)
        //                controller.navigationBar.addSubview(largeTitleLabel)
        largeTitleLabel.snp.makeConstraints { make in
            let rightOffset = isHasButton ? Constants.titleLargeRightOffset : Constants.titleSmallRightOffset
            make.top.equalToSuperview().offset(Constants.navBarHeightSmallState)
            make.right.equalToSuperview().offset(-rightOffset)
            make.left.equalToSuperview().offset(16)
//            make.width.equalTo(300)
//            make.height.equalTo(82)
        }
    }
    
    func setButton(with imageName: String) {
        isHasButton = true
        addSubview(actioButton)
        //                controller.navigationBar.addSubview(actioButton)
        actioButton.setImage(UIImage(named: imageName), for: .normal)
        actioButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-Constants.buttonRightOffset)
            make.bottom.equalToSuperview().offset(-Constants.buttonBottomMarginForLargeState)
            make.size.equalTo(Constants.buttonSizeForLargeState)
        }
    }
    
    func didScrollView(_ height: CGFloat) {
        if height > Constants.scrollMaxHeight {
            setTitleState(with: .show)
        } else {
            if height < Constants.scrollMaxHeight {
                setTitleState(with: .hidden)
            } else {
                setTitleState(with: .none)
            }
        }
        
        if isHasButton {
            moveAndResizeButton(for: height)
        }
    }
}

private extension TestBar {
    @objc func didTapOnActioButton() {
        customDelegate?.didTapOnActioButton()
    }
    
    func moveAndResizeButton(for height: CGFloat) {
        let coefficient: CGFloat = {
            let delta = height - Constants.navBarHeightSmallState
            let heightDifferenceBetweenStates = (Constants.navBarHeightLargeState - Constants.navBarHeightSmallState)
            return delta / heightDifferenceBetweenStates
        }()
        
        let factor = Constants.buttonSizeForSmallState / Constants.buttonSizeForLargeState
        let yTranslation: CGFloat = {
            let ysizeDiff = Constants.buttonSizeForLargeState * (1.0 - factor)
            let maxYTranslation = Constants.buttonBottomMarginForLargeState - Constants.buttonBottomMarginForSmallState + ysizeDiff
            return max(0, min(maxYTranslation, (maxYTranslation - coefficient * (Constants.buttonBottomMarginForSmallState + ysizeDiff))))
        }()
        
        let xSizeDiff = Constants.buttonSizeForLargeState * (2.0 - factor)
        let xTranslation = max(0, xSizeDiff - coefficient * xSizeDiff)
        let scale: CGFloat = {
            let sizeAddendumFactor = coefficient * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()
        
        actioButton.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
    }
    
    func setTitleState(with state: NavigationBarState) {
        switch state {
            case .hidden, .none:
                largeTitleLabel.isHidden = true
            case .show:
                largeTitleLabel.isHidden = false
        }
        
        customDelegate?.didUpdateTitleState(with: state)
    }
}
