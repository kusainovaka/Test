//
//  SecondLargeTitle.swift
//  Test
//
//  Created by Kamila Kussainova on 10/26/20.
//  Copyright © 2020 Kamila Kusainova. All rights reserved.
//

import UIKit

class SecondLargeTitle: UIViewController {
    
    var navBar: CustomNavigationBar?
    let titleText = "Платежи и переводы"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupTableView()
        title = titleText
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navBar?.removeAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        setupNavBar()
    }
    
    func layoutUI() {
        let someView = UIView()
        someView.backgroundColor = .orange
        view.addSubview(someView)
        someView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupTableView() {
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.backgroundColor = .orange
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupNavBar() {
        if let navigationController = navigationController {
            print(navigationController.navigationItem.hidesBackButton, "MODE")
            navBar = CustomNavigationBar(title: titleText, controller: navigationController)
            navBar?.setButton(with: "settings")
            navBar?.customDelegate = self
        }
    }
}

extension SecondLargeTitle: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Kamila Hello"
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let height = navigationController?.navigationBar.frame.height else { return }
        navBar?.didScrollView(height)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ThirdLargeTitlePage()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SecondLargeTitle: CustomNavigationBarDelegate {
    func didUpdateTitleState(with state: NavigationBarState) {
        switch state {
            case .hidden:
                navigationItem.title = titleText
            case .show, .none:
                navigationItem.title = ""
        }
    }
}
