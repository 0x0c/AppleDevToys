//
//  AllToolsRouter.swift
//  DevToys
//
//  Created by Akira on 03/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import UIKit

protocol AllToolsRouterInput: AnyObject {
    // MARK: View transitions

    func presentNumberBaseViewController()
    func presentBase64ViewController()
    func presentJWTDecodeViewController()
    func presentUUIDViewController()
}

final class AllToolsRouter {
    private unowned let viewController: AllToolsViewController

    init(viewController: AllToolsViewController) {
        self.viewController = viewController
    }

    static func assembleModule() -> AllToolsViewController {
        let view = AllToolsViewController()
        let interactor = AllToolsInteractor()
        let router = AllToolsRouter(viewController: view)
        let presenter = AllToolsPresenter(view: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }
}

extension AllToolsRouter: AllToolsRouterInput {
    func presentNumberBaseViewController() {
        viewController.navigationController?.pushViewController(NumberBaseRouter.assembleModule(), animated: true)
    }

    func presentBase64ViewController() {
        viewController.navigationController?.pushViewController(Base64Router.assembleModule(), animated: true)
    }

    func presentJWTDecodeViewController() {
        viewController.navigationController?.pushViewController(JWTDecodeRouter.assembleModule(), animated: true)
    }

    func presentUUIDViewController() {
        viewController.navigationController?.pushViewController(UUIDRouter.assembleModule(), animated: true)
    }
}
