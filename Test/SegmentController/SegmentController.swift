//
//  SegmentController.swift
//  Test
//
//  Created by Kamila on 4/7/20.
//  Copyright © 2020 Kamila Kusainova. All rights reserved.
//

import UIKit

fileprivate enum RegistrationFlowType {
    case one
    case two
    case three
    case four
}

class SegmentController: UIViewController {
    private var state: RegistrationFlowType = .one
    private var tableView = UITableView()
    private var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Hello", for: .normal)
        return button
    }()
    
    private var cardScanButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 20, y: 0, width: 24 + 12, height: 20))
        button.backgroundColor = .red
        button.contentMode = .center
        return button
    }()
    
    private var textField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        title = "This is multiline title for navigation bar"
        navigationController?.navigationBar.prefersLargeTitles = true
        //        configureTableView()
        //        changeState(.one)
        test()
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .green
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func test() {
        view.addSubview(textField)
        textField.rightView = cardScanButton
        textField.rightViewMode = .always
        textField.backgroundColor = .white
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.height.equalTo(56)
            make.left.right.equalToSuperview().inset(16)
        }
    }
}


extension SegmentController {
    private func changeState(_ state: RegistrationFlowType) {
        self.state = state
        updateContext()
    }
    
    private func updateContext() {
        clearView()
        switch state {
        case .one:
            oneLayout()
        case .two:
            twoLayout()
        case .three:
            print("Three")
        case .four:
            print("Four")
            
        }
    }
    
    private func layoutUI() {
        let segmentController = CustomSegmentController(sections: 4)
        view.addSubview(segmentController)
        segmentController.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(25)
            make.leading.trailing.equalToSuperview()
        }
        
        segmentController.selectedView(selected: 2)
    }
    
    
    private func clearView() {
        button.removeTarget(nil, action: nil, for: .allEvents)
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
    }
    
    private func oneLayout() {
        view.addSubview(button)
        button.addTarget(self, action: #selector(didTapOne), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(45)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(56)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(button.snp.top).offset(-8)
        }
    }
    
    private func twoLayout() {
        view.addSubview(button)
        button.backgroundColor = .brown
        button.setTitle("Two", for: .normal)
        button.addTarget(self, action: #selector(didTapTwo), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(45)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(56)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(button.snp.top).offset(-8)
        }
    }
    
    @objc func didTapOne() {
        changeState(.two)
    }
    
    @objc func didTapTwo() {
        changeState(.three)
    }
}
