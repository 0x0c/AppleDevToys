//
//  AllToolsViewController.swift
//  DevToys
//
//  Created by Akira on 03/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import CompositionalLayoutViewController
import CompositionalLayoutViewControllerViperExtension
import UIKit

protocol AllToolsViewInput: CollectionViewInput {
    // MARK: Callback from presenter
}

final class AllToolsViewController: CompositionalLayoutViewController {
    // MARK: Stored instance properties

    var presenter: AllToolsPresenterInput!

    // MARK: Computed instance properties

    // MARK: IBOutlets

    // MARK: View Life-Cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        provider = self
        presenter.viewDidLoad()
    }

    // MARK: Other private methods
}

extension AllToolsViewController: SectionProvider {
    var sections: [CollectionViewSection] {
        return presenter.sections
    }
}

extension AllToolsViewController: AllToolsViewInput {
    func update(sections: [CollectionViewSection]) {
        // TODO:
        updateDataSource(sections)
    }
}
