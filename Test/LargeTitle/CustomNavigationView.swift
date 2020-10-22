//
//  CustomNavigationBar.swift
//  OnlineBank
//
//  Created by Kamila Kussainova on 10/22/20.
//

import UIKit

enum NavigationBarState {
    case hidden
    case show
    case none
}

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

protocol CustomNavigationBarDelegate: class {
    func didUpdateTitleState(with state: NavigationBarState)
    func didTapOnActioButton()
}

extension CustomNavigationBarDelegate {
    func didTapOnActioButton() { }
}

class CustomNavigationBar {
    
    weak var delegate: CustomNavigationBarDelegate?
    
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
    
    private let controller: UINavigationController
    private var isHasButton = false
    
    init(title: String, controller: UINavigationController) {
        self.controller = controller
        controller.navigationBar.prefersLargeTitles = true
        
        setupTitle(with: title)
    }
    
    private func setupTitle(with title: String) {
        largeTitleLabel.text = title
        controller.navigationBar.addSubview(largeTitleLabel)
        largeTitleLabel.snp.makeConstraints { make in
            let rightOffset = isHasButton ? Constants.titleLargeRightOffset : Constants.titleSmallRightOffset
            make.right.equalToSuperview().offset(-rightOffset)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview()
        }
    }
    
    func setButton(with imageName: String) {
        isHasButton = true
        controller.navigationBar.addSubview(actioButton)
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


private extension CustomNavigationBar {
    @objc func didTapOnActioButton() {
        delegate?.didTapOnActioButton()
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
        
        delegate?.didUpdateTitleState(with: state)
    }
}
