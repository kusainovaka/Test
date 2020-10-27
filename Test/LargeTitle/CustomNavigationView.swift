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
    
    weak var customDelegate: CustomNavigationBarDelegate?
    
    private lazy var actioButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.buttonSizeForLargeState / 2
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapOnActioButton), for: .touchUpInside)
        return button
    }()
    
    private let largeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let controller: UINavigationController
    private var isHasButton = false
    
    init(title: String, controller: UINavigationController) {
        self.controller = controller
        controller.navigationBar.prefersLargeTitles = true
        
    //        translatesAutoresizingMaskIntoConstraints = false
    //        prefersLargeTitles = true
    //        backgroundColor = .orange
        setupTitle()
        largeTitleLabel.text = title
        updateNavBarToClearBackground()
    }
    
    func setTitle(text: String) {
        largeTitleLabel.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func removeAll() {
        controller.navigationBar.subviews.forEach { view in
            view.removeFromSuperview()
        }
    }
    
    private func setupTitle() {
        controller.navigationBar.addSubview(largeTitleLabel)
//        largeTitleLabel.backgroundColor = .red
    
        largeTitleLabel.snp.makeConstraints { make in
            let rightOffset = isHasButton ? Constants.titleLargeRightOffset : Constants.titleSmallRightOffset

//            make.top.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(Constants.navBarHeightSmallState)
            make.right.equalToSuperview().offset(-rightOffset)
            make.left.equalToSuperview().offset(16)
            //            make.bottom.equalToSuperview().offset(16) // TODO: KAmila ???
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
    
    // TODO: Kamila
    @available(iOS 13.0, *)
    private func navigationBarSetup(with backgroundColor: UIColor, textColor: UIColor) {
//
//        controller.navigationBar.prefersLargeTitles = true
//
//       let style = UINavigationBarAppearance()
//       style.configureWithDefaultBackground()
//
//       style.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 18)]
//
//        controller.navigationBar.standardAppearance = style
//        controller.navigationBar.compactAppearance = style
//
//
//       //Configure Large Style
//       let largeStyle = UINavigationBarAppearance()
//       largeStyle.configureWithTransparentBackground()
//
//       largeStyle.largeTitleTextAttributes = [.font: UIFont.systemFont(ofSize: 28)]
//
//        controller.navigationBar.scrollEdgeAppearance = largeStyle
        
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.shadowColor = nil
        navBarAppearance.titleTextAttributes = [.foregroundColor: textColor]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: textColor]
        navBarAppearance.backgroundColor = backgroundColor
        controller.navigationBar.standardAppearance = navBarAppearance
        controller.navigationBar.scrollEdgeAppearance = navBarAppearance
        controller.navigationBar.compactAppearance = navBarAppearance
    }
    
    private func navigationBarSetup(backgroundColor: UIColor, textColor: UIColor, shadowImage: UIImage) {
        controller.navigationBar.backgroundColor = backgroundColor
        controller.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: textColor]
        controller.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: textColor]
        controller.navigationBar.shadowImage = UIImage()
        controller.navigationBar.layer.shadowColor = UIColor.clear.cgColor
        controller.navigationBar.layer.shadowOffset = .zero
    }
    
    private func updateNavBarToClearBackground() {
        if #available(iOS 13, *) {
            navigationBarSetup(with: .white, textColor: .black)
        } else {
            navigationBarSetup(backgroundColor: .white, textColor: .black, shadowImage: UIImage())
        }
    }
}

private extension CustomNavigationBar {
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
