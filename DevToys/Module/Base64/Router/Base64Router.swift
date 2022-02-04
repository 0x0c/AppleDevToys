//
//  Base64Router.swift
//  DevToys
//
//  Created by Akira on 04/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import UIKit

protocol Base64RouterInput: AnyObject {
    // MARK: View transitions
}

final class Base64Router {
    private unowned let viewController: Base64ViewController

    init(viewController: Base64ViewController) {
        self.viewController = viewController
    }

    static func assembleModule() -> Base64ViewController {
        guard let view = R.storyboard.base64ViewController().instantiateInitialViewController() as? Base64ViewController else {
            fatalError("Fail to load Base64ViewController from Storyboard.")
        }
        let interactor = Base64Interactor()
        let router = Base64Router(viewController: view)
        let presenter = Base64Presenter(view: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter

        return view
    }
}

extension Base64Router: Base64RouterInput {}
