//
//  JWTDecodeRouter.swift
//  DevToys
//
//  Created by Akira on 04/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import UIKit

protocol JWTDecodeRouterInput: AnyObject {
    // MARK: View transitions
}

final class JWTDecodeRouter {
    private unowned let viewController: JWTDecodeViewController

    init(viewController: JWTDecodeViewController) {
        self.viewController = viewController
    }

    static func assembleModule() -> JWTDecodeViewController {
        guard let view = R.storyboard.jwtDecodeViewController().instantiateInitialViewController() as? JWTDecodeViewController else {
            fatalError("Fail to load JWTDecodeViewController from Storyboard.")
        }
        let interactor = JWTDecodeInteractor()
        let router = JWTDecodeRouter(viewController: view)
        let presenter = JWTDecodePresenter(view: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }
}

extension JWTDecodeRouter: JWTDecodeRouterInput {}
