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
}

final class AllToolsRouter {
    private unowned let viewController: AllToolsViewController

    init(viewController: AllToolsViewController) {
        self.viewController = viewController
    }

    static func assembleModule() -> AllToolsViewController {
        let view = AllToolsViewController()
        // TODO: Create a Storyboard with the same name as "AllTools".
        // TODO: And Change "AllTools" of "R.storyboard.AllTools" to lowercase.
        // guard let view = R.storyboard.AllTools.instantiateInitialViewController() else {
        //     fatalError("Fail to load AllToolsViewController from Storyboard.")
        // }
        let interactor = AllToolsInteractor()
        let router = AllToolsRouter(viewController: view)
        let presenter = AllToolsPresenter(view: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }
}

extension AllToolsRouter: AllToolsRouterInput {}
