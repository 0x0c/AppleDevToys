//
//  ToolGridSection.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/03.
//

import CompositionalLayoutViewController
import Reusable
import UIKit

final class ToolGridSection: CollectionViewSection {
    var snapshotItems: [AnyHashable] {
        return items
    }

    let items: [ToolGridCellViewModel]

    init(items: [ToolGridCellViewModel]) {
        self.items = items
    }

    func registerCell(collectionView: UICollectionView) {
        collectionView.register(cellType: ToolGridCell.self)
    }

    func registerSupplementaryView(collectionView: UICollectionView) {}

    func layoutSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let contentSize = environment.container.effectiveContentSize
        let columns = contentSize.width > 800 ? 4 : 2
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(ToolGridCell.defaultSize.height)
            ),
            subitem: item,
            count: columns
        )
        group.interItemSpacing = .fixed(16)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = Constant.defaultSectionInsets
        return section
    }

    func cell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as ToolGridCell
        cell.viewModel = items[indexPath.row]
        return cell
    }

    func configureSupplementaryView(_ view: UICollectionReusableView, indexPath: IndexPath) {}

    func supplementaryView(_ collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        return nil
    }
}
