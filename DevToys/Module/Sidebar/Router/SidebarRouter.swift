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

    func presentAllToolsViewController()
    func presentNumberBaseViewController()
    func presentBase64ViewController()
    func presentJWTDecodeViewController()
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

extension SidebarRouter: SidebarRouterInput {
    func presentAllToolsViewController() {
        if viewController.splitViewController?.viewController(for: .secondary) is AllToolsViewInput == false {
            viewController.splitViewController?.setViewController(
                UINavigationController(rootViewController: AllToolsRouter.assembleModule()),
                for: .secondary
            )
        }
    }

    func presentNumberBaseViewController() {
        if viewController.splitViewController?.viewController(for: .secondary) is NumberBaseViewInput == false {
            viewController.splitViewController?.setViewController(
                UINavigationController(rootViewController: NumberBaseRouter.assembleModule()),
                for: .secondary
            )
        }
    }

    func presentBase64ViewController() {
        if viewController.splitViewController?.viewController(for: .secondary) is Base64ViewInput == false {
            viewController.splitViewController?.setViewController(
                UINavigationController(rootViewController: Base64Router.assembleModule()),
                for: .secondary
            )
        }
    }

    func presentJWTDecodeViewController() {
        if viewController.splitViewController?.viewController(for: .secondary) is JWTDecodeViewInput == false {
            viewController.splitViewController?.setViewController(
                UINavigationController(rootViewController: JWTDecodeRouter.assembleModule()),
                for: .secondary
            )
        }
    }
}
