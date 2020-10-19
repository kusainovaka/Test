//
//  ViewController.swift
//  Test
//
//  Created by Kamila Kusainova on 03.10.2018.
//  Copyright © 2018 Kamila Kusainova. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    @IBOutlet weak var pinkView: UIView!

    
    @IBOutlet weak var pinkTop: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        
        pinkView.backgroundColor = .red
        pinkTop.constant = 0
        
//        pinkView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        
        /*
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        view.addSubview(button)

        button.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(70)
        }
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)*/
    }
    
    @objc func buttonAction() {
        customAlert()
    }

    
    func customAlert(){

        let alertView = CustomAlertViewController()
//        alertView.view.superview?.frame = CGRect(x: 0, y: 200, width: 400, height: 300)
        present(alertView, animated: true, completion: nil)
    }
    
    func alertView() {
        let alertView = UIAlertController(title: "hello", message: "", preferredStyle: .actionSheet)
        let view = UIView(frame: CGRect(x: 0, y: 0, width: alertView.view.frame.width - 15, height: 40))
        view.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        alertView.view.addSubview(view)

        let action1 = UIAlertAction(title: "Action1", style: .default, handler: nil)
        action1.setValue(UIImage(named: "settings.png")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), forKey: "image")
        
        let action2 = UIAlertAction(title: "Action2", style: .destructive, handler: nil)
        action2.setValue(UIImage(named: "settings.png")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), forKey: "image")

        alertView.addAction(action1)
        alertView.addAction(action2)

        present(alertView, animated: true, completion: nil)
    }
}

