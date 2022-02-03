//
//  SidebarViewController.swift
//  DevToys
//
//  Created by Akira on 03/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import CompositionalLayoutViewController
import CompositionalLayoutViewControllerViperExtension
import UIKit

protocol SidebarViewInput: CollectionViewInput {
    // MARK: Callback from presenter
}

final class SidebarViewController: CompositionalLayoutViewController {
    // MARK: Stored instance properties

    var presenter: SidebarPresenterInput!

    // MARK: Computed instance properties

    // MARK: IBOutlets

    // MARK: View Life-Cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "DevToys"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        provider = self
        presenter.viewDidLoad()
    }

    // MARK: Other private methods

    override func didSelectItem(at indexPath: IndexPath) {
        presenter.didItemSelect(indexPath: indexPath)
    }

    override func updateDataSource(_ sections: [CollectionViewSection], animateWhenUpdate: Bool = true) {
        registerViews(sections)
        var snapshot = NSDiffableDataSourceSnapshot<AnyHashable, AnyHashable>()
        snapshot.appendSections(sections.map { $0.snapshotSection })
        dataSource.apply(snapshot, animatingDifferences: false)

        for section in sections {
            if let section = section as? SidebarSection {
                if let header = section.header {
                    var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<AnyHashable>()
                    sectionSnapshot.append([header])
                    sectionSnapshot.append(
                        section.items,
                        to: header
                    )
                    sectionSnapshot.expand([header])
                    dataSource.apply(sectionSnapshot, to: section.snapshotSection)
                }
                else {
                    var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<AnyHashable>()
                    sectionSnapshot.append([section.items])
                    dataSource.apply(sectionSnapshot, to: section.snapshotSection)
                }
            }
        }
    }
}

extension SidebarViewController: SectionProvider {
    var sections: [CollectionViewSection] {
        return presenter.sections
    }
}

extension SidebarViewController: SidebarViewInput {
    func update(sections: [CollectionViewSection]) {
        updateDataSource(sections)
    }
}
