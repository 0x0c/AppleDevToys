//
//  NumberInputFormSection.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/04.
//

import Reusable

extension NumberInputFormSection {
    static func form(_ forms: [TextFormAvailable], headerTitle: String) -> NumberInputFormSection {
        return .init(
            items: forms,
            headerTitle: headerTitle
        )
    }
}

class NumberInputFormSection: TextFormSection {
    let headerTitle: String

    init(items: [TextFormAvailable], headerTitle: String) {
        self.headerTitle = headerTitle
        super.init(items: items, cellHeight: 30)
    }

    override func layoutSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = super.layoutSection(environment: environment)
        section.boundarySupplementaryItems = [TextHeaderView.supplementaryItem()]
        return section
    }

    override func registerSupplementaryView(collectionView: UICollectionView) {
        collectionView.register(supplementaryViewType: TextHeaderView.self, ofKind: TextHeaderView.elementKind)
    }

    override func configureSupplementaryView(_ view: UICollectionReusableView, indexPath: IndexPath) {
        if let view = view as? TextHeaderView {
            view.text = headerTitle
        }
    }
}
