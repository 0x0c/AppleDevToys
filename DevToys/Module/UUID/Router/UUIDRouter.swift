//
//  UUIDRouter.swift
//  DevToys
//
//  Created by Akira on 04/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import UIKit

protocol UUIDRouterInput: AnyObject {
    // MARK: View transitions
}

final class UUIDRouter {
    private unowned let viewController: UUIDViewController

    init(viewController: UUIDViewController) {
        self.viewController = viewController
    }

    static func assembleModule() -> UUIDViewController {
        guard let view = R.storyboard.uuidViewController().instantiateInitialViewController() as? UUIDViewController else {
            fatalError("Fail to load UUIDViewController from Storyboard.")
        }
        let interactor = UUIDInteractor()
        let router = UUIDRouter(viewController: view)
        let presenter = UUIDPresenter(view: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }
}

extension UUIDRouter: UUIDRouterInput {}
