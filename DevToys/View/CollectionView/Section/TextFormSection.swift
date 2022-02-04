//
//  TextFormSection.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/03.
//

import Combine
import CompositionalLayoutViewController
import Reusable
import UIKit

extension TextFormSection {
    static func form(_ forms: [TextFormAvailable], cellHeight: CGFloat = TextFormCell.defaultHeight) -> TextFormSection {
        return .init(
            items: forms,
            cellHeight: cellHeight
        )
    }
}

extension TextFormSection {
    static let performResignFirstResponder = Notification.Name("TextFormSection.performResignFirstResponder")
}

class TextFormSection: CollectionViewSection, DefaultSupplementalViewProvider {
    static func resignFirstResponder() {
        NotificationCenter.default.post(
            name: TextFormSection.performResignFirstResponder,
            object: nil
        )
    }

    var snapshotItems: [AnyHashable] {
        return items as! [AnyHashable]
    }
    private var cellHeight: CGFloat
    let items: [TextFormAvailable]

    init(items: [TextFormAvailable], cellHeight: CGFloat = TextFormCell.defaultHeight) {
        self.items = items
        self.cellHeight = cellHeight
        self.items.link()
    }

    func registerCell(collectionView: UICollectionView) {
        for item in items {
            item.registerCell(collectionView)
        }
    }

    func registerSupplementaryView(collectionView: UICollectionView) {}

    func layoutSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(cellHeight)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.contentInsets = Constant.defaultSectionInsets
        return section
    }

    func cell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell? {
        let item = items[indexPath.row]
        let cell = item.dequeueCell(collectionView, for: indexPath)
        cell.viewModel = item
        return cell
    }

    func configureSupplementaryView(_ view: UICollectionReusableView, indexPath: IndexPath) {}
}
