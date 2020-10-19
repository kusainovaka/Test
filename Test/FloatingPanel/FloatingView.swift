//
//  FloatingView.swift
//  Test
//
//  Created by Kamila on 3/12/20.
//  Copyright © 2020 Kamila Kusainova. All rights reserved.
//

import UIKit

class FloatingView: UIView {
    
    private lazy var gripView = UIView()
    private var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("cancel", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUI() {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        clipsToBounds = false
        layer.cornerRadius = 12
        cancelButton.addTarget(self, action: #selector(cancelButtonHandler), for: .touchUpInside)
        
        addSubview(gripView)
        addSubview(cancelButton)
        
        gripView.frame = CGRect(x: 0, y: 0, width: frame.width, height: 16)
        cancelButton.frame = CGRect(x: 0, y: 12, width: 80, height: 24)
    }
    
    @objc private func cancelButtonHandler() { }
}
