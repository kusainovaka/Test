//
//  FloatingPanelPage.swift
//  Test
//
//  Created by Kamila on 3/12/20.
//  Copyright © 2020 Kamila Kusainova. All rights reserved.
//

import UIKit

class FloatingPanelPage: UIViewController {
    
    private let actionView = FloatingView()
    private let dimmerView = UIView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dimmerView.alpha = 0
//        view.addGestureRecognizer(tapGesture)
//        actionView.addGestureRecognizer(panGesture)
        setupAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        dimmerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.addSubview(dimmerView)
        view.addSubview(actionView)
    }
    
    private func setupAnimation() {
        actionView.backgroundColor = .red
           let actionViewFrame = actionView.frame
           let viewFrame = view.frame
        let actionViewHeight: CGFloat = 200//actionView.tableView.contentSize.height + 44
           
           UIView.animate(withDuration: 0.4, animations: {
               self.actionView.frame = CGRect(x: 0, y: -viewFrame.height, width: actionViewFrame.width, height: viewFrame.height - actionViewHeight)
               self.dimmerView.alpha = 1
           })
       }
}
