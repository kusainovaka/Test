//
//  AuthCell.swift
//  Test
//
//  Created by Kamila Kusainova on 19.10.2018.
//  Copyright © 2018 Kamila Kusainova. All rights reserved.
//

import UIKit

class AuthCell: UITableViewCell {

    var textfield = CustomTextFieldView(placholder: "Телефон")
    var activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.addSubview(textfield)
        activityIndicator.color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        textfield.rightView = activityIndicator
        textfield.rightViewMode = .always
        activityIndicator.startAnimating()
        textfield.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
    }
}
