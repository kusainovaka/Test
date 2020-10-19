//
//  CustomTextFieldView.swift
//  Test
//
//  Created by Kamila Kusainova on 19.10.2018.
//  Copyright © 2018 Kamila Kusainova. All rights reserved.
//

import UIKit

class CustomTextFieldView: UITextField {
    init(placholder: String) {
        super.init(frame: .zero)
        textColor = #colorLiteral(red: 0.5921568627, green: 0.07450980392, blue: 0.3137254902, alpha: 1)
        tintColor = #colorLiteral(red: 0.5921568627, green: 0.07450980392, blue: 0.3137254902, alpha: 1)
        attributedPlaceholder = NSAttributedString(string: placholder,
                                attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5921568627, green: 0.07450980392, blue: 0.3137254902, alpha: 1)])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
