//
//  SidebarPresenter.swift
//  DevToys
//
//  Created by Akira on 03/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import CompositionalLayoutViewController
import CompositionalLayoutViewControllerViperExtension
import UIKit

protocol SidebarPresenterInput: CollectionViewPresenterInput {
    // MARK: View Life-Cycle methods

    func viewDidLoad()

    // MARK: Other methods called from View
}

final class SidebarPresenter {
    // MARK: VIPER properties

    weak var view: SidebarViewInput!
    var interactor: SidebarInteractorInput!
    var router: SidebarRouterInput!

    // MARK: Stored instance properties

    // MARK: Computed instance properties

    init(view: SidebarViewInput, interactor: SidebarInteractorInput, router: SidebarRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension SidebarPresenter: SidebarPresenterInput {
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
        if let section = interactor.section(for: indexPath.section) as? SidebarSection {
            if case let .toolItem(item) = section.item(for: indexPath) {
                switch item {
                case .allTools:
                    router.presentAllToolsViewController()
                case .numberBase:
                    router.presentNumberBaseViewController()
                case .base64EncodeDecode:
                    router.presentBase64ViewController()
                default:
                    // TODO: 画面切り替え
                    print(item)
                }
            }
        }
    }
}

extension SidebarPresenter: SidebarInteractorOutput {}
