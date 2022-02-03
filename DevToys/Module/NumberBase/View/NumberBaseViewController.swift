//
//  NumberBaseViewController.swift
//  DevToys
//
//  Created by Akira on 03/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import SwiftUI

import CompositionalLayoutViewController
import CompositionalLayoutViewControllerViperExtension
import UIKit

protocol NumberBaseViewInput: CollectionViewInput {
    // MARK: Callback from presenter
}

final class NumberBaseViewController: CompositionalLayoutViewController {
    // MARK: Stored instance properties

    var presenter: NumberBasePresenterInput!

    // MARK: Computed instance properties

    // MARK: IBOutlets

    // MARK: View Life-Cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        provider = self
        presenter.viewDidLoad()
    }

    override func layoutConfiguration() -> UICollectionViewCompositionalLayoutConfiguration {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 16
        return configuration
    }
    // MARK: Other private methods
}

extension NumberBaseViewController: SectionProvider {
    var sections: [CollectionViewSection] {
        return presenter.sections
    }
}

extension NumberBaseViewController: NumberBaseViewInput {
    func update(sections: [CollectionViewSection]) {
        updateDataSource(sections)
    }
}
