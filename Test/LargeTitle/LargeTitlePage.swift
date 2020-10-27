//
//  LargeTitlePage.swift
//  Test
//
//  Created by Kamila Kussainova on 10/19/20.
//  Copyright © 2020 Kamila Kusainova. All rights reserved.
//

import UIKit

class LargeTitlePage: UIViewController {
    let tableView = UITableView()
    let titleText = "Введите номер телефона"
    var navBar: CustomNavigationBar?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = titleText
        setupTableView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navBar?.removeAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        setupNavBar()
        test()
    }
    
    func test() {
        navigationController?.navigationBar.prefersLargeTitles = true
        for navItem in(self.navigationController?.navigationBar.subviews)! {
             for itemSubView in navItem.subviews {
                print("!11111")
                 if let largeLabel = itemSubView as? UILabel {
                    print("!22222")
                    largeLabel.text = self.title
                     largeLabel.textColor = .green
                     largeLabel.numberOfLines = 0
                     largeLabel.lineBreakMode = .byWordWrapping
                 }
             }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        navigationController?.navigationBar.sizeToFit()
    }
    
    func setupNavBar() {
        if let navigationController = navigationController {
            navBar = CustomNavigationBar(title: titleText, controller: navigationController)
            navBar?.setButton(with: "settings")
//            navBar?.customDelegate = self
        }
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
//        setupTableHeaderView()
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
        cell.textLabel?.text = "Kamila Hello"
//        cell.backgroundColor = .blue
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let height = navigationController?.navigationBar.frame.height else { return }
//        guard let navBa = navigationController?.navigationBar as? TestBar else {
//            return
//        }
//        navBa.customDelegate = self
//        navBa.didScrollView(height)
//        navBar?.didScrollView(height)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SecondLargeTitle()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LargeTitlePage: CustomNavigationBarDelegate {
    func didUpdateTitleState(with state: NavigationBarState) {
        switch state {
            case .hidden:
                navigationItem.title = titleText
            case .show, .none:
                navigationItem.title = ""
        }
    }    
}

extension UINavigationBar {

    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 150)
    }
}
