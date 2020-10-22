//
//  LargeTitlePage.swift
//  Test
//
//  Created by Kamila Kussainova on 10/19/20.
//  Copyright © 2020 Kamila Kusainova. All rights reserved.
//

import UIKit

private struct Const {
    /// Image height/width for Large NavBar state
    static let ImageSizeForLargeState: CGFloat = 48
    /// Margin from right anchor of safe area to right anchor of Image
    static let ImageRightMargin: CGFloat = 16
    /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
    static let ImageBottomMarginForLargeState: CGFloat = 12
    /// Margin from bottom anchor of NavBar to bottom anchor of Image for Small NavBar state
    static let ImageBottomMarginForSmallState: CGFloat = 6
    /// Image height/width for Small NavBar state
    static let ImageSizeForSmallState: CGFloat = 32
    /// Height of NavBar for Small state. Usually it's just 44
    static let NavBarHeightSmallState: CGFloat = 44
    /// Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
    static let NavBarHeightLargeState: CGFloat = 96.5
}

enum NavBarState {
    case hidden
    case show
    case none
}

class LargeTitlePage: UIViewController {
    
    let tableView = UITableView()
    let addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.layer.cornerRadius = Const.ImageSizeForLargeState / 2
        button.clipsToBounds = true
        return button
    }()
    let titleLabel = UILabel()
    let titleText = "Платежи и переводы"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupNavBar()
        setupTableView()
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: 375, height: 200)
        imageAnimation()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        setupTableHeaderView()
    }
    
    func setupTableHeaderView() {
        let segmentView = UIView()
        segmentView.backgroundColor = .red
        let filterView = UIView()
        filterView.backgroundColor = .green
        let headerView = UIStackView()
        headerView.distribution = .fillProportionally
        headerView.axis = .vertical
        headerView.addArrangedSubview(segmentView)
        headerView.addArrangedSubview(filterView)
        headerView.snp.makeConstraints { make in
            make.width.equalTo(375)
            make.height.equalTo(56)
        }
        
        tableView.tableHeaderView = headerView
    }
}

extension LargeTitlePage: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Hello"
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let height = navigationController?.navigationBar.frame.height else { return }
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
    
    func setupTitle(type: NavBarState) {
        switch type {
            case .hidden:
                navigationItem.title = titleText
                titleLabel.isHidden = true
            case .show:
                navigationItem.title = ""
                titleAnimation()
                titleLabel.isHidden = false
            case .none:
                navigationItem.title = ""
                titleLabel.isHidden = true
        }
    }
    
    func imageAnimation() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-52)
            make.bottom.equalToSuperview().offset(-Const.ImageBottomMarginForLargeState)
            make.size.equalTo(Const.ImageSizeForLargeState)
        }
    }
    
    func titleAnimation() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.text = titleText
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        navigationBar.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            //            let iPhone5 = 20 ? 60
            make.right.equalTo(addButton.snp.left).offset(-20)
            make.bottom.equalToSuperview()
        }
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
}
