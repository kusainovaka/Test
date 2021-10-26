//
//  DurationViewController.swift
//  Test
//
//  Created by Kamila Kussainova on 21.10.2021.
//  Copyright © 2021 Kamila Kusainova. All rights reserved.
//

import UIKit

class DurationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        addTagsView()
    }
    
    func addTagsView() {
        let titles = ["3", "6", "9", "12", "18", "24", "36", "48", "60"]
        let tags = titles.map { button(with: $0) }
        
        let frame = CGRect(x: 0, y: 250, width: 260, height: 200)
        let tagsView = TagsView(frame: frame)
        tagsView.backgroundColor = .green
        tagsView.create(cloud: tags)
        
        view.addSubview(tagsView)
        tagsView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.left.right.equalToSuperview().inset(16)
            make.height.lessThanOrEqualTo(72)
        }
        
        tagsView.setNeedsLayout()

        print(tagsView.frame.height)
    }
    
    private func button(with title: String) -> UIButton {
        let font = UIFont.preferredFont(forTextStyle: .headline)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let size = title.size(withAttributes: attributes)
        
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = font
        button.backgroundColor = .yellow
        button.setTitleColor(.darkGray, for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = size.height / 2
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.frame = CGRect(x: 0.0, y: 0.0, width: size.width + 10.0, height: size.height + 10.0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 0.0, right: 5.0)
        return button
    }
}
