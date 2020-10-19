//
//  DefaultPage.swift
//  Test
//
//  Created by Kamila Kussainova on 10/14/20.
//  Copyright © 2020 Kamila Kusainova. All rights reserved.
//

import UIKit

class DefaultPage: UIViewController {
    //
    var didTapOn: VoidCallback?
    
    private let textLabel = UILabel()
    private let textView = UIView()
    private let textButton = UIButton()
    
    private let viewModel: DefaultViewModel
    
    init(viewModel: DefaultViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        layoutUI()
        config()
    }
}

private extension DefaultPage {
    func setupViews() {
        view.addSubview(textLabel)
        view.addSubview(textView)
        view.addSubview(textButton)
    }
    
    func layoutUI() {
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
        }
    }
    
    func config() {
        textLabel.text = viewModel.title
    }
}

extension DefaultPage: UITableViewDelegate {
    
}

private extension DefaultPage {
    // MARK: Actions
    @objc func didTapOnView() {
        
    }
}
