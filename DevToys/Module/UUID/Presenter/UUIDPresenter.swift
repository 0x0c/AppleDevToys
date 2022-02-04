//
//  UUIDPresenter.swift
//  DevToys
//
//  Created by Akira on 04/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import CompositionalLayoutViewController
import CompositionalLayoutViewControllerViperExtension
import UIKit

protocol UUIDPresenterInput: AnyObject {
    // MARK: View Life-Cycle methods

    func viewDidLoad()

    // MARK: Other methods called from View
}

final class UUIDPresenter {
    // MARK: VIPER properties

    weak var view: UUIDViewInput!
    var interactor: UUIDInteractorInput!
    var router: UUIDRouterInput!

    // MARK: Stored instance properties

    // MARK: Computed instance properties

    init(view: UUIDViewInput, interactor: UUIDInteractorInput, router: UUIDRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension UUIDPresenter: UUIDPresenterInput {
    func viewDidLoad() {}
}

extension UUIDPresenter: UUIDInteractorOutput {}
