//
//  Base64Presenter.swift
//  DevToys
//
//  Created by Akira on 04/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import UIKit

protocol Base64PresenterInput: AnyObject {
    // MARK: View Life-Cycle methods

    func viewDidLoad()

    // MARK: Other methods called from View
}

final class Base64Presenter {
    // MARK: VIPER properties

    weak var view: Base64ViewInput!
    var interactor: Base64InteractorInput!
    var router: Base64RouterInput!

    // MARK: Stored instance properties

    // MARK: Computed instance properties

    init(view: Base64ViewInput, interactor: Base64InteractorInput, router: Base64RouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension Base64Presenter: Base64PresenterInput {
    func viewDidLoad() {
        // TODO: Implement if needed
    }
}

extension Base64Presenter: Base64InteractorOutput {}
