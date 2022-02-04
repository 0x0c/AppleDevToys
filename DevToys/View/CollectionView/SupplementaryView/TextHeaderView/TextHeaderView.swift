//
//  TextHeaderView.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/04.
//

import UIKit
import Reusable

class TextHeaderView: UICollectionReusableView, NibReusable {
    static let defaultHeight: CGFloat = 24
    static let elementKind = String(describing: TextHeaderView.self)

    @IBOutlet private var textLabel: UILabel!

    var font: UIFont! {
        get {
            return textLabel.font
        }
        set {
            textLabel.font = newValue
        }
    }

    var text: String? {
        didSet {
            textLabel.text = text
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static func supplementaryItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let item = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(TextHeaderView.defaultHeight)
            ),
            elementKind: TextHeaderView.elementKind,
            alignment: .top
        )
        item.pinToVisibleBounds = true
        return item
    }
}
