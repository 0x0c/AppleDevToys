//
//  AllToolsPresenter.swift
//  DevToys
//
//  Created by Akira on 03/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import CompositionalLayoutViewController
import CompositionalLayoutViewControllerViperExtension
import UIKit

protocol AllToolsPresenterInput: CollectionViewPresenterInput {
    // MARK: View Life-Cycle methods

    func viewDidLoad()

    // MARK: Other methods called from View
}

final class AllToolsPresenter {
    // MARK: VIPER properties

    weak var view: AllToolsViewInput!
    var interactor: AllToolsInteractorInput!
    var router: AllToolsRouterInput!

    // MARK: Stored instance properties

    // MARK: Computed instance properties

    init(view: AllToolsViewInput, interactor: AllToolsInteractorInput, router: AllToolsRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension AllToolsPresenter: AllToolsPresenterInput {
    var sections: [CollectionViewSection] {
        return interactor.sections
    }

    func viewDidLoad() {
        view.update(sections: interactor.sections)
    }

    func section(for sectionIndex: Int) -> CollectionViewSection {
        return interactor.section(for: sectionIndex)
    }

    func didItemSelect(indexPath: IndexPath) {
        if let section = interactor.section(for: indexPath.section) as? ToolGridSection {
            switch section.items[indexPath.row].toolItem {
            case .numberBase:
                router.presentNumberBaseViewController()
            case .base64EncodeDecode:
                router.presentBase64ViewController()
            default:
                // TODO:
                break
            }
        }
    }
}

extension AllToolsPresenter: AllToolsInteractorOutput {}
