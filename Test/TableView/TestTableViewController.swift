//
//  TestTableViewController.swift
//  Test
//
//  Created by Kamila Kussainova on 11.01.2021.
//  Copyright © 2021 Kamila Kusainova. All rights reserved.
//

import UIKit

enum AccountListType: CaseIterable {
    case account
    case cardAccount
    case card
}

class TestTableViewController: UIViewController {
    let tableView = UITableView()
    var cellList = AccountListType.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.register(CardAccountCell.self, forCellReuseIdentifier: "CardAccountCell")
        tableView.register(AccountCell.self, forCellReuseIdentifier: "AccountCell")
        tableView.register(CardCell.self, forCellReuseIdentifier: "CardCell")

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension TestTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = cellList[indexPath.row]
        switch type {
            case .cardAccount:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardAccountCell", for: indexPath) as? CardAccountCell else {
                    return .init()
                }
                cell.delegate = self
                cell.configure()
                return cell
            case .account:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath) as? AccountCell else {
                    return .init()
                }
                cell.configure()
                return cell
            case .card:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as? CardCell else {
                    return .init()
                }
                cell.configure()
                return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
    }
}


extension TestTableViewController: CardAccountCellDelegate {
    func didTapOnButton(with cell: CardAccountCell) {
        tableView.beginUpdates()
        cell.addCards()
        tableView.endUpdates()
        print("Hello")
    }
}
