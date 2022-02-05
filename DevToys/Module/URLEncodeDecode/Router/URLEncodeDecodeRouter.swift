//
//  URLEncodeDecodeRouter.swift
//  DevToys
//
//  Created by Akira on 05/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import UIKit

protocol URLEncodeDecodeRouterInput: AnyObject {
    // MARK: View transitions
}

final class URLEncodeDecodeRouter {
    private unowned let viewController: URLEncodeDecodeViewController

    init(viewController: URLEncodeDecodeViewController) {
        self.viewController = viewController
    }

    static func assembleModule() -> URLEncodeDecodeViewController {
        guard let view = R.storyboard.urlEncodeDecodeViewController().instantiateInitialViewController() as? URLEncodeDecodeViewController else {
            fatalError("Fail to load URLEncodeDecodeViewController from Storyboard.")
        }
        let interactor = URLEncodeDecodeInteractor()
        let router = URLEncodeDecodeRouter(viewController: view)
        let presenter = URLEncodeDecodePresenter(view: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }
}

extension URLEncodeDecodeRouter: URLEncodeDecodeRouterInput {}
