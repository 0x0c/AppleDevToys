//
//  CollectionViewSection+Register.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/04.
//

import CompositionalLayoutViewController
import UIKit

protocol DefaultSupplementalViewProvider {}

extension DefaultSupplementalViewProvider where Self: CollectionViewSection {
    func supplementaryView(_ collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        return collectionView.devtoys_dequeueReusableSupplementaryView(kind: kind, indexPath: indexPath, section: self)
    }
}

extension UICollectionView {
    func devtoys_dequeueReusableSupplementaryView(
        kind: String,
        indexPath: IndexPath,
        section: CollectionViewSection
    ) -> UICollectionReusableView? {
        let view: UICollectionReusableView = {
            switch kind {
//            case SectionHeaderView.elementKind:
//                let view = dequeueReusableSupplementaryView(ofKind: kind, for: indexPath) as SectionHeaderView
//                view.indexPath = indexPath
//                view.disclosureIndicatorHidden = !(section is DisclosureIndicatorAvailable)
//                return view
//            case SmallSectionHeaderView.elementKind:
//                return dequeueReusableSupplementaryView(ofKind: kind, for: indexPath) as SmallSectionHeaderView
            case TextHeaderView.elementKind:
                return dequeueReusableSupplementaryView(ofKind: kind, for: indexPath) as TextHeaderView
//            case SeparatorView.sectionSeparatorElementKind, SeparatorView.cellSeparatorElementKind:
//                return dequeueReusableSupplementaryView(ofKind: kind, for: indexPath) as SeparatorView
            default:
                assertionFailure("Unexpected element kind: \(kind).")
                return UICollectionReusableView()
            }
        }()
        return view
    }
}
