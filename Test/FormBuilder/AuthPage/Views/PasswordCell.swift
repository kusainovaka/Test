//
//  PasswordCell.swift
//  Test
//
//  Created by Kamila Kusainova on 19.10.2018.
//  Copyright © 2018 Kamila Kusainova. All rights reserved.
//

import UIKit

protocol PasswordCellDelegate {
    func showPassword(cell:PasswordCell, isSelected: Bool)
}

class PasswordCell: UITableViewCell {
    
    var delegate: PasswordCellDelegate?
    var textfield = CustomTextFieldView(placholder: "Пароль")
    var passwordButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.setImage(#imageLiteral(resourceName: "passwordShow"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "settings"), for: .selected)
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.addSubview(textfield)
        textfield.rightView = passwordButton
        textfield.rightViewMode = .always
        textfield.isSecureTextEntry = true
        
        passwordButton.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        textfield.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
    }
    
    @objc func showPassword() {
        passwordButton.isSelected = !passwordButton.isSelected
        guard  passwordButton.isSelected else {
            textfield.isSecureTextEntry = true
            delegate?.showPassword(cell: self, isSelected: false)
            return
        }
        textfield.isSecureTextEntry = false
        delegate?.showPassword(cell: self, isSelected: true)
    }
}
