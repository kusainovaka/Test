//
//  DarkModePage.swift
//  Test
//
//  Created by Kamila on 3/11/20.
//  Copyright © 2020 Kamila Kusainova. All rights reserved.
//

import UIKit

class DarkModePage: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            view.backgroundColor = UIColor(named: "backgroundColor")
        } else {
            // Fallback on earlier versions
        }
        
        setupView()
    }
    
    private func setupView() {
        let button = UIButton()
        button.backgroundColor = .orange
        button.setTitle("Open", for: .normal)
        button.addTarget(self, action: #selector(didTapOnButton), for: .touchUpInside)
        
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.size.equalTo(120)
        }
    }
    
    @objc private func didTapOnButton() {
        let floatingPanelPage = FloatingPanelPage()
        present(floatingPanelPage, animated: true, completion: nil)
    }
}
