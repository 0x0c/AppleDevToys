//
//  ConfigurationSection.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/03.
//

import CompositionalLayoutViewController
import Reusable
import UIKit

final class ConfigurationSection: CollectionViewSection {
    var snapshotItems: [AnyHashable] {
        return items
    }

    let items: [ConfigurationItem]

    init(items: [ConfigurationItem]) {
        self.items = items
    }

    func registerCell(collectionView: UICollectionView) {
        collectionView.register(cellType: SwitchCell.self)
    }

    func registerSupplementaryView(collectionView: UICollectionView) {}

    func layoutSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(SwitchCell.defaultHeight)
            ),
            subitem: item,
            count: 1
        )
        group.interItemSpacing = .fixed(16)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = Constant.defaultSectionInsets
        return section
    }

    func cell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell? {
        let item = items[indexPath.row]
        switch item {
        case let .toggle(viewModel):
            let cell = collectionView.dequeueReusableCell(for: indexPath) as SwitchCell
            cell.viewModel = viewModel
            return cell
        }
    }

    func configureSupplementaryView(_ view: UICollectionReusableView, indexPath: IndexPath) {}

    func supplementaryView(_ collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        return nil
    }
}
