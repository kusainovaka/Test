//
//  LoginViewModel.swift
//  Test
//
//  Created by Kamila Kusainova on 28.11.2018.
//  Copyright © 2018 Kamila Kusainova. All rights reserved.
//

import Foundation
import RxSwift

protocol LoginViewModelProtocol {
    func updateProtocol(text: String)
}

class LoginViewModel {
    
    var emailText = Variable<String>("")
    var passwordText = Variable<String>("")
    var isValid: Observable<Bool> {
        return Observable.combineLatest(emailText.asObservable(), passwordText.asObservable()) {
            email, password in
            email.count > 3 && password.count > 3
        }
    }
    
    //change closure (string) in 
    var delegate: LoginViewModelProtocol?
    var update:((LoginViewModel) -> Void)?
    var sum: ((Int, Int) -> Int)?
    var emailTextClosure: String = "" {
        didSet {
            checkButton()
        }
    }
    
    var passwordTextClosure: String = "" {
        didSet {
            checkButton()
        }
    }
    
    var isEnableClosure: Bool = false {
        didSet {
            update?(self)
        }
    }
    
   private func checkButton() {
        guard emailTextClosure.count > 3 && passwordTextClosure.count > 3 else {
            isEnableClosure = false
            return
        }
      isEnableClosure = true
    }
}
