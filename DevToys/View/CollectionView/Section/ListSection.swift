//
//  ListSection.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/03.
//

import CompositionalLayoutViewController
import UIKit

class ListSection<Model: Hashable>: CollectionViewSection {
    var snapshotItems: [AnyHashable] {
        return items
    }

    let items: [Model]
    private var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, Model>!
    private let cellCongicuration: (UICollectionViewListCell, IndexPath, Model) -> UIListContentConfiguration
    private let backgroundConfiguration: ((IndexPath) -> UIBackgroundConfiguration?)?
    private let appearance: UICollectionLayoutListConfiguration.Appearance
    private let headerMode: UICollectionLayoutListConfiguration.HeaderMode

    init(
        items: [Model],
        cellCongicuration: @escaping ((UICollectionViewListCell, IndexPath, Model) -> UIListContentConfiguration),
        backgroundConfiguration: ((IndexPath) -> UIBackgroundConfiguration?)? = nil,
        appearance: UICollectionLayoutListConfiguration.Appearance = .plain,
        headerMode: UICollectionLayoutListConfiguration.HeaderMode = .none
    ) {
        self.items = items
        self.cellCongicuration = cellCongicuration
        self.backgroundConfiguration = backgroundConfiguration
        self.appearance = appearance
        self.headerMode = headerMode
        prepare()
    }

    private func prepare() {
        cellRegistration = UICollectionView.CellRegistration<
            UICollectionViewListCell,
            Model
        > { [weak self] cell, indexPath, item in
            guard let weakSelf = self else { return }
            cell.contentConfiguration = weakSelf.cellCongicuration(cell, indexPath, item)
            cell.backgroundConfiguration = weakSelf.backgroundConfiguration?(indexPath)
        }
    }

    func registerCell(collectionView: UICollectionView) {}

    func registerSupplementaryView(collectionView: UICollectionView) {}

    func layoutSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        var config = UICollectionLayoutListConfiguration(appearance: appearance)
        config.headerMode = headerMode
        return NSCollectionLayoutSection.list(
            using: config,
            layoutEnvironment: environment
        )
    }

    func cell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell? {
        return collectionView.dequeueConfiguredReusableCell(
            using: cellRegistration,
            for: indexPath,
            item: items[indexPath.row]
        )
    }

    func supplementaryView(_ collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        return nil
    }

    func configureSupplementaryView(_ view: UICollectionReusableView, indexPath: IndexPath) {}
}
