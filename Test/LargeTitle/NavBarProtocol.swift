//
//  NavBarProtocol.swift
//  Test
//
//  Created by Kamila Kussainova on 10/26/20.
//  Copyright © 2020 Kamila Kusainova. All rights reserved.
//

import UIKit

protocol NavBarProtocol {
    func setTitle(with text: String, imageName: String)
    func didUpdateTitleState(with state: NavigationBarState)
    func didTapOnActioButton()
}

extension NavBarProtocol where Self: UIViewController {
    
    func setTitle(with text: String, imageName: String) {
        guard let navigationController = self.navigationController else { return }
        let some = CustomNavigationBar(title: text, controller: navigationController)
        some.setButton(with: imageName)
    }
}
