//
//  CheckStackViewController.swift
//  Test
//
//  Created by Kamila Kusainova on 22.10.2018.
//  Copyright © 2018 Kamila Kusainova. All rights reserved.
//

import UIKit

class CheckStackViewController: UIViewController {
    
    var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StackViewCell.self, forCellReuseIdentifier: "StackViewCell")
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-50)
        }
    }
}

extension CheckStackViewController: UITableViewDelegate, UITableViewDataSource {
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StackViewCell", for: indexPath) as! StackViewCell
            return cell
    }
}


