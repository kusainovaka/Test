//
//  ShineViewController.swift
//  Test
//
//  Created by Kamila Kusainova on 28.10.2018.
//  Copyright © 2018 Kamila Kusainova. All rights reserved.
//

import UIKit
import SpriteKit

class ShineViewController: UIViewController {
    
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.662745098, green: 0, blue: 0.2901960784, alpha: 1)
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    let  label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        label.isUserInteractionEnabled = true
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return label
    }()
    var sceneView = SKView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        view.addSubview(cardView)
        cardView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(200)
            $0.width.equalTo(300)
        }
        
        view.addSubview(label)
        label.text = "1234-1234-1234-1242"
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.centerY.equalToSuperview()
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapToLabel))
        label.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func tapToLabel() {
        guard sceneView.isHidden else {
            label.isHidden = false
            sceneView.isHidden = true
            return
        }
        label.isHidden = true
        sceneView.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sceneView = SKView(frame: CGRect(x: label.frame.origin.x, y: label.frame.origin.y, width: label.frame.width, height: label.frame.height))
        let scene = SKScene(size: CGSize(width: label.frame.width, height: label.frame.height))
        scene.position = CGPoint(x: label.frame.origin.x / 4, y: 0)
        scene.backgroundColor = .clear
        sceneView.backgroundColor = .clear
        let node = SKEmitterNode(fileNamed: "MyParticle")!
        node.particleSize = CGSize(width: 15, height: 15)
        scene.addChild(node)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapToLabel))
        sceneView.addGestureRecognizer(tapGesture)
        sceneView.isHidden = true
        sceneView.presentScene(scene)
        view.addSubview(sceneView)
    }
}
