//
//  JWTDecodePresenter.swift
//  DevToys
//
//  Created by Akira on 04/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import UIKit

protocol JWTDecodePresenterInput: AnyObject {
    // MARK: View Life-Cycle methods

    func viewDidLoad()

    // MARK: Other methods called from View
}

final class JWTDecodePresenter {
    // MARK: VIPER properties

    weak var view: JWTDecodeViewInput!
    var interactor: JWTDecodeInteractorInput!
    var router: JWTDecodeRouterInput!

    // MARK: Stored instance properties

    // MARK: Computed instance properties

    init(view: JWTDecodeViewInput, interactor: JWTDecodeInteractorInput, router: JWTDecodeRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension JWTDecodePresenter: JWTDecodePresenterInput {
    func viewDidLoad() {}
}

extension JWTDecodePresenter: JWTDecodeInteractorOutput {}
