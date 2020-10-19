//
//  StackViewCell.swift
//  Test
//
//  Created by Kamila Kusainova on 22.10.2018.
//  Copyright © 2018 Kamila Kusainova. All rights reserved.
//

import UIKit

class StackViewCell: UITableViewCell {
    var icon = UIImageView()
    var textfield = UITextField()
    var label = UILabel()
    
    var stackView = UIStackView()
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.addSubview(stackView)
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        stackView.addArrangedSubview(icon)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textfield)
        icon.image = #imageLiteral(resourceName: "passwordShow")
        label.text = "Label"
        textfield.text = "Textfield"
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
    }
}

