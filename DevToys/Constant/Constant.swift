//
//  Constant.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/03.
//

import UIKit

struct Constant {
    static var defaultContentInset: UIEdgeInsets {
        return .init(top: 0, left: 23, bottom: 0, right: 23)
    }

    static var defaultSectionInsets: NSDirectionalEdgeInsets {
        return .init(
            top: defaultContentInset.top,
            leading: defaultContentInset.left,
            bottom: defaultContentInset.bottom,
            trailing: defaultContentInset.right
        )
    }

    static var buttonCornerRadius: CGFloat = 7
    static var defaultCornerRadius: CGFloat = 8
}
