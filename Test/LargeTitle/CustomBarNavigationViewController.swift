//
//  CustomBarNavigationViewController.swift
//  Test
//
//  Created by Kamila Kussainova on 10/26/20.
//  Copyright © 2020 Kamila Kusainova. All rights reserved.
//

import UIKit

class CustomBarNavigationViewController: UINavigationController {

    init() {
        super.init(navigationBarClass: TestBar.self, toolbarClass: nil)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override init(rootViewController: UIViewController) {
        super.init(navigationBarClass: TestBar.self, toolbarClass: nil)

        self.viewControllers = [rootViewController]
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
