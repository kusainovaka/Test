//
//  FirstPage.swift
//  Test
//
//  Created by Kamila Kusainova on 26.11.2018.
//  Copyright © 2018 Kamila Kusainova. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class FirstPage: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Title"
        return label
    }()
    
    var loginField: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        return textfield
    }()
    
    var passwordField: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.isSecureTextEntry = true
        return textfield
    }()
    
    var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    var viewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        view.addSubview(loginField)
        loginField.placeholder = "Login"
        loginField.backgroundColor = .white
        loginField.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(40)
        }
        
        view.addSubview(passwordField)
        passwordField.placeholder = "Password"
        passwordField.backgroundColor = .white
        passwordField.snp.makeConstraints {
            $0.top.equalTo(loginField.snp.bottom).offset(10)
            $0.width.height.centerX.equalTo(loginField)
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(40)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(loginField.snp.top).offset(-30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(150)
        }
        
//        rxBind()
        
        closureViewChanges()
        updateViewModel()
//        test()
    }
    
    func request() {
        
    }
    
    func rxBind() {
        _ = loginField.rx.text.map{ $0 ?? "" }.bind(to: viewModel.emailText)
        _ = passwordField.rx.text.map{ $0 ?? "" }.bind(to: viewModel.passwordText)
        
        _ = viewModel.isValid.bind(to: loginButton.rx.isEnabled)
        
        viewModel.isValid.subscribe(onNext: { isValid in
            self.titleLabel.text = isValid ? "Enable" : "Not enable"
            self.loginButton.backgroundColor = isValid ? .green : .red
        }).disposed(by: disposeBag)
    }
    
    //Closure
    func closureViewChanges() {
        loginField.addTarget(self, action: #selector(check), for: .allEditingEvents)
        passwordField.addTarget(self, action: #selector(check), for: .allEditingEvents)
        
        viewModel.update = {  [weak self] _ in
            self?.updateViewModel()
        }
    }
    
    func updateViewModel() {
        loginButton.backgroundColor = viewModel.isEnableClosure ? .green : .red
        loginButton.isEnabled = viewModel.isEnableClosure
        titleLabel.text = viewModel.isEnableClosure ? "Enable" : "Not enable"
    }
    
    //TEST
    func publishSubject() {
        let subject = PublishSubject<String>()
        subject.onNext("1")
        
        let subcriptionOne = subject.subscribe(onNext: { string in
            print("First: ", string)
        })
        subject.onNext("One")
        subject.onNext("Two")
        
        let subcriptionTwo = subject.subscribe(onNext: { (event) in
            print("Second: \(event)", event)
        })
        subject.onNext("Three")
        subcriptionOne.dispose()
        subject.onNext("Four")
        subject.onNext(loginField.text ?? "nilll")
        subject.onCompleted()
        subcriptionTwo.dispose()
        
        subject.onNext("HEllo")
    }
    
    
    func test() {
        let publishSubject = PublishSubject<String>()
        let publishObservable: Observable<String> = publishSubject
        publishSubject.onNext("Publish: 1")
        publishSubject.onNext("Publish: 2")
        publishSubject.onNext("Publish: 3")

        publishObservable.subscribe(onNext: { text in
            print(text)
        }).disposed(by: disposeBag)
        publishSubject.onNext("🐙Finish publish")
       
         let replaySubject = ReplaySubject<String>.create(bufferSize: 2)
         let replayObservable: Observable<String> = replaySubject
         replaySubject.onNext("Replay: 1")
         replaySubject.onNext("Replay: 2")
         replaySubject.onNext("Replay: 3")
         
         replayObservable.subscribe(onNext: { text in
         print(text)
         }).disposed(by: disposeBag)
        replaySubject.onNext("👾Finish replay")
        
         
         let behaviorSubject = BehaviorSubject<String>(value: "Behavior value")
         let behaviorObservable: Observable<String> = behaviorSubject
         behaviorSubject.onNext("Behavior: 1")
         behaviorSubject.onNext("Behavior: 2")
         behaviorSubject.onNext("Behavior: 3")
         
         behaviorObservable.subscribe(onNext: { text in
         print(text)
         }).disposed(by: disposeBag)
         
         behaviorSubject.onNext("🐡Finish behavior")
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    @objc func check(_ textfield: UITextField) {
        if loginField == textfield {
            viewModel.emailTextClosure = textfield.text ?? ""
        } else if passwordField == textfield {
            viewModel.passwordTextClosure = textfield.text ?? "" }
    }
}
