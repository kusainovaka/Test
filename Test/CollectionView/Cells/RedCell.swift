//
//  RedCell.swift
//  Test
//
//  Created by Kamila on 3/3/20.
//  Copyright © 2020 Kamila Kusainova. All rights reserved.
//

import UIKit

class RedCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
