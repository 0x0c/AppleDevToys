//
//  URLPresenter.swift
//  DevToys
//
//  Created by Akira on 05/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import UIKit

protocol URLEncodeDecodePresenterInput: AnyObject {
    // MARK: View Life-Cycle methods

    func viewDidLoad()

    // MARK: Other methods called from View
}

final class URLEncodeDecodePresenter {
    // MARK: VIPER properties

    weak var view: URLEncodeDecodeViewInput!
    var interactor: URLEncodeDecodeInteractorInput!
    var router: URLEncodeDecodeRouterInput!

    // MARK: Stored instance properties

    // MARK: Computed instance properties

    init(view: URLEncodeDecodeViewInput, interactor: URLEncodeDecodeInteractorInput, router: URLEncodeDecodeRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension URLEncodeDecodePresenter: URLEncodeDecodePresenterInput {
    func viewDidLoad() {}
}

extension URLEncodeDecodePresenter: URLEncodeDecodeInteractorOutput {}
