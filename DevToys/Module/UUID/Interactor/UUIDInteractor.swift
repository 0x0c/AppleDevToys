//
//  UUIDInteractor.swift
//  DevToys
//
//  Created by Akira on 04/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import CompositionalLayoutViewController
import CompositionalLayoutViewControllerViperExtension
import Foundation

protocol UUIDInteractorInput: AnyObject {
    // MARK: Methods for modifying repository
}

protocol UUIDInteractorOutput: AnyObject {
    // MARK: Callback methods from repository
}

final class UUIDInteractor {
    // MARK: VIPER property

    weak var presenter: UUIDInteractorOutput!

    // MARK: Stored instance properties

    // MARK: Computed instance properties

    // MARK: Initializer

    init() {}

    // MARK: Other private methods
}

extension UUIDInteractor: UUIDInteractorInput {}
