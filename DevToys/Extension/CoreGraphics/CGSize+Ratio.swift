//
//  CGSize+Ratio.swift
//  Whitemap
//
//  Created by Akira Matsuda on 2021/01/08.
//

import CoreGraphics

extension CGSize {
    func heightRatio() -> CGFloat {
        return width / height
    }

    func widthRatio() -> CGFloat {
        return height / width
    }
}
