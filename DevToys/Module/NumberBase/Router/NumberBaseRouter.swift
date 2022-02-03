//
//  NumberBaseRouter.swift
//  DevToys
//
//  Created by Akira on 03/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import UIKit

protocol NumberBaseRouterInput: AnyObject {
    // MARK: View transitions
}

final class NumberBaseRouter {
    private unowned let viewController: NumberBaseViewController

    init(viewController: NumberBaseViewController) {
        self.viewController = viewController
    }

    static func assembleModule() -> NumberBaseViewController {
        let view = NumberBaseViewController()
        let interactor = NumberBaseInteractor()
        let router = NumberBaseRouter(viewController: view)
        let presenter = NumberBasePresenter(view: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }
}

extension NumberBaseRouter: NumberBaseRouterInput {}
