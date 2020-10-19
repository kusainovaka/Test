//
//  AuthViewController.swift
//  Test
//
//  Created by Kamila Kusainova on 19.10.2018.
//  Copyright © 2018 Kamila Kusainova. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AuthCell.self, forCellReuseIdentifier: "AuthCell")
        tableView.register(PasswordCell.self, forCellReuseIdentifier: "PasswordCell")
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-50)
        }
    }
}

extension AuthViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AuthCell", for: indexPath) as! AuthCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PasswordCell", for: indexPath) as! PasswordCell
            cell.delegate = self
            return cell
        default:
            return UITableViewCell.init()
        }
    }
}

extension AuthViewController: PasswordCellDelegate {
    func showPassword(cell: PasswordCell, isSelected: Bool) {
        cell.passwordButton.isSelected = isSelected
    }
}
