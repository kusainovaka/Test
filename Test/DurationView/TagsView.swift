//
//  TagsView.swift
//  Test
//
//  Created by Kamila Kussainova on 21.10.2021.
//  Copyright © 2021 Kamila Kusainova. All rights reserved.
//

import UIKit

class TagsView: UIView {

    // MARK: - Properties

    var offset: CGFloat = 5

    // MARK: - Public functions

    func create(cloud tags: [UIButton]) {
        var x = offset
        var y = offset
        for (index, tag) in tags.enumerated() {
            tag.frame = CGRect(x: x, y: y, width: 48,//tag.frame.width,
                               height: tag.frame.height)
            x += tag.frame.width + offset

            let nextTag = index <= tags.count - 2 ? tags[index + 1] : tags[index]
            let nextTagWidth = nextTag.frame.width + offset

            if x + nextTagWidth > frame.width {
                x = offset
                y += tag.frame.height + offset
            }

            addSubview(tag)
        }
    }
}
