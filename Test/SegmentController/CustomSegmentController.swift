//
//  CustomSegmentController.swift
//  Test
//
//  Created by Kamila on 4/7/20.
//  Copyright © 2020 Kamila Kusainova. All rights reserved.
//

import UIKit

class CustomSegmentController: UIView {
    
    private var setionView = UIView()
    private var stackView = UIStackView()
    private var sectionCount: Int
    
    init(sections: Int) {
        sectionCount = sections
        super.init(frame: .zero)
        
        backgroundColor = .blue
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUI() {
        addSubview(stackView)
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        stackView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(5)
            make.left.right.equalToSuperview().inset(8)
        }
        
        for _ in 1...sectionCount {
            let view = UIView()
            view.layer.cornerRadius = 3
            view.backgroundColor = .green
            stackView.addArrangedSubview(view)
        }
    }
    
    func selectedView(selected: Int) {
        for (index, view) in stackView.arrangedSubviews.enumerated() {
            if index < selected {
                view.backgroundColor = .black
            }
        }
    }
}
