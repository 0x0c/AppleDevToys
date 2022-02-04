//
//  Base64Interactor.swift
//  DevToys
//
//  Created by Akira on 04/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import Foundation

protocol Base64InteractorInput: AnyObject {
    // MARK: Methods for modifying repository
}

protocol Base64InteractorOutput: AnyObject {
    // MARK: Callback methods from repository
}

final class Base64Interactor {
    // MARK: VIPER property

    weak var presenter: Base64InteractorOutput!

    // MARK: Stored instance properties

    // MARK: Computed instance properties

    // MARK: Initializer

    init() {}

    // MARK: Other private methods
}

extension Base64Interactor: Base64InteractorInput {}
