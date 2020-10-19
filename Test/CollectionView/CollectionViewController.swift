//
//  CollectionViewController.swift
//  Test
//
//  Created by Kamila on 3/3/20.
//  Copyright © 2020 Kamila Kusainova. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    
    private var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.itemSize = CGSize(width: 375 - 80, height: 135)
        let collectionView =  UICollectionView(frame: CGRect(x: 0, y: 120, width: 375, height: 135), collectionViewLayout: collectionViewLayout)
        return collectionView
    }()
    
    var array = [1, 2, 3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        configCollectionView()
    }
    
    private func configCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.register(RedCell.self, forCellWithReuseIdentifier: "RedCell")
        collectionView.register(WhiteCell.self, forCellWithReuseIdentifier: "WhiteCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Test")

        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Test", for: indexPath)

        if indexPath.row == 1 {
            cell.backgroundColor = .red
        } else {
            cell.backgroundColor = .white
        }
        return cell
    }
}
