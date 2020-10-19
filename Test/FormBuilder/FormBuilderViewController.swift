//
//  FormBuilderViewController.swift
//  Test
//
//  Created by Kamila Kusainova on 18.10.2018.
//  Copyright © 2018 Kamila Kusainova. All rights reserved.
//

import UIKit
import ContactsUI

class FormBuilderViewController: UIViewController, CNContactPickerDelegate {
    
    var button = UIButton()
    var label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
      
        view.addSubview(button)
        button.backgroundColor = .blue
        button.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.size.equalTo(100)
        }
        button.addTarget(self, action: #selector(openContact), for: .touchUpInside)
        
        view.addSubview(label)
        label.text = "KAMILAAAAA"
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-80)
            $0.width.equalTo(200)
        }
    }
    
    @objc func openContact() {
        let cnPicker = CNContactPickerViewController()
        cnPicker.delegate = self
        cnPicker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        present(cnPicker, animated: true, completion: nil)
    }
   
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
        contactProperty.contact.phoneNumbers.forEach { contact in
            if contactProperty.identifier == contact.identifier {
                let phoneNumber = stripped(contact.value.stringValue.stripped)
                label.text = phoneNumber
            }
        }
    }
    
    func stripped(_ text: String) -> String {
        let normalCharacter = Set("1234567890")
        return text.filter {normalCharacter.contains($0) }
    }

}


extension String {
    var stripped: String {
        let normalCharacter = Set("1234567890")
        return self.filter {normalCharacter.contains($0) }
    }
}
