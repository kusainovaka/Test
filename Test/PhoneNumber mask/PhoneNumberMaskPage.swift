//
//  PhoneNumberMaskPage.swift
//  Test
//
//  Created by Kamila Kussainova on 9/14/20.
//  Copyright © 2020 Kamila Kusainova. All rights reserved.
//

import UIKit

class PhoneNumberMaskPage: UIViewController {
    
    private let countryCodeLabel: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Manrope-Bold", size: 12)
        textField.placeholder = "+ "
        textField.keyboardType = .numberPad
        textField.backgroundColor = .white
        return textField
    }()
    
    private let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "* * * * * * * * *"
        textField.keyboardType = .numberPad
        textField.backgroundColor = .white
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        layoutUI()
        
        for family in UIFont.familyNames {
            print("family:", family)
            for font in UIFont.fontNames(forFamilyName: family) {
                print("font:", font)
            }
        }
    }
    
    private func layoutUI() {
        view.addSubview(countryCodeLabel)
            countryCodeLabel.delegate = self
            countryCodeLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(300)
                make.left.equalToSuperview().inset(25)
                make.width.equalTo(60)
                make.height.equalTo(20)
            }
        view.addSubview(phoneNumberTextField)
            phoneNumberTextField.delegate = self
            phoneNumberTextField.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(300)
                make.right.equalToSuperview().inset(25)
                make.height.equalTo(countryCodeLabel)
                make.left.equalTo(countryCodeLabel.snp.right).offset(30)
            }
    }
}


extension PhoneNumberMaskPage: UITextFieldDelegate {
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard let text = textField.text else { return true }
            let newText = text + string
            let newLength = newText.count - range.length
            if textField == countryCodeLabel {
                if text.count > range.location {
                    let some = string + text.filterNumerical()
                        if newText.count == 1 {
                            return false
                        } else if newText.count > 5 {
                            phoneNumberTextField.text = string
                            phoneNumberTextField.becomeFirstResponder()
                    }
    //                countryCodeLabel.text = some
                    print(some, "New text with old")
                    print(string, "Entered text")
                    print(newText, "text + string")
                    print(text, "Textfield text")
    //                delegate?.didEditCountry(with: some)
                } else {
                    let some = string + text.filterNumerical()
                    print("MASK 👻👻👻", some)
                    print(string, newText, text, "12321313")
    //                if newText.count > 1 {
    //                    phoneNumberTextField.text = string
    //                    phoneNumberTextField.becomeFirstResponder()
    //                }
                }
            }
            if textField == phoneNumberTextField {
                print("PhoneNumber 💩💩💩💩", newText)
            }
            return true
        }
}


extension String {

    var isNilOrEmpty: Bool {
        return ((self as? String) ?? "").isEmpty
    }
    
    func filterNumerical() -> String {
        return filter("01234567890".contains)
    }
}
