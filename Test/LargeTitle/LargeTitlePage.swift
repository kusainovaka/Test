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

class LargeTitlePage: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    let imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .orange
        image.layer.cornerRadius = Const.ImageSizeForLargeState / 2
        image.clipsToBounds = true
        return image
    }()
    let titleLabel = UILabel()
    
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
        titleAnimation()
    }

    func imageAnimation() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-52)
            make.bottom.equalToSuperview().offset(-Const.ImageBottomMarginForLargeState)
            make.size.equalTo(Const.ImageSizeForLargeState)
        }
    }
    
    func titleAnimation() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.text = "Платежи и переводы"
        titleLabel.numberOfLines = 2
        navigationBar.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(imageView.snp.left).offset(-60)
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

        imageView.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
        
        // TODO:
        if coeff == 0 {
            titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
            titleLabel.snp.removeConstraints()
            titleLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().offset(-18)
            }
            imageView.snp.updateConstraints { make in
                make.bottom.equalToSuperview().offset(-14)
            }
            
        } else {
            titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
            titleLabel.snp.removeConstraints()

            titleLabel.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(16)
                make.right.equalTo(imageView.snp.left).offset(-60)
                make.bottom.equalToSuperview()
            }
        }
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
//        setupTableHeaderView()
    }
    
    func setupTableHeaderView() {
        let headerView = UIView()
        headerView.backgroundColor = .green
        headerView.snp.makeConstraints { make in
            make.width.equalTo(375)
            make.height.equalTo(56)
        }
        
        tableView.tableHeaderView = headerView
    }
}

extension LargeTitlePage: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .blue
//        headerView.snp.makeConstraints { make in
////            make.width.equalTo(375)
//            make.height.equalTo(56)
//        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }
    
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
        moveAndResizeImage(for: height)
    }
}
