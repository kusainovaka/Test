//
//  ThirdLargeTitlePage.swift
//  Test
//
//  Created by Kamila Kussainova on 10/26/20.
//  Copyright © 2020 Kamila Kusainova. All rights reserved.
//

import UIKit

class ThirdLargeTitlePage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        title = "titleText"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}
