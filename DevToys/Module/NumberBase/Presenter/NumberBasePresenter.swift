//
//  NumberBasePresenter.swift
//  DevToys
//
//  Created by Akira on 03/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import CompositionalLayoutViewController
import CompositionalLayoutViewControllerViperExtension
import UIKit

protocol NumberBasePresenterInput: CollectionViewPresenterInput {
    // MARK: View Life-Cycle methods

    func viewDidLoad()

    // MARK: Other methods called from View
}

final class NumberBasePresenter {
    // MARK: VIPER properties

    weak var view: NumberBaseViewInput!
    var interactor: NumberBaseInteractorInput!
    var router: NumberBaseRouterInput!

    // MARK: Stored instance properties

    // MARK: Computed instance properties

    init(view: NumberBaseViewInput, interactor: NumberBaseInteractorInput, router: NumberBaseRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension NumberBasePresenter: NumberBasePresenterInput {
    var sections: [CollectionViewSection] {
        return interactor.sections
    }

    func viewDidLoad() {
        view.update(sections: interactor.sections)
    }

    func section(for sectionIndex: Int) -> CollectionViewSection {
        return interactor.section(for: sectionIndex)
    }

    func didItemSelect(indexPath: IndexPath) {}
}

extension NumberBasePresenter: NumberBaseInteractorOutput {}
