//
//  SidebarRouter.swift
//  DevToys
//
//  Created by Akira on 03/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import UIKit

protocol SidebarRouterInput: AnyObject {
    // MARK: View transitions
}

final class SidebarRouter {
    private unowned let viewController: SidebarViewController

    init(viewController: SidebarViewController) {
        self.viewController = viewController
    }

    static func assembleModule() -> SidebarViewController {
        let view = SidebarViewController()
        let interactor = SidebarInteractor()
        let router = SidebarRouter(viewController: view)
        let presenter = SidebarPresenter(view: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }
}

extension SidebarRouter: SidebarRouterInput {}
