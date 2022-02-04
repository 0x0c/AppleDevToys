//
//  JWTDecodeInteractor.swift
//  DevToys
//
//  Created by Akira on 04/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import Foundation

protocol JWTDecodeInteractorInput: AnyObject {
    // MARK: Methods for modifying repository
}

protocol JWTDecodeInteractorOutput: AnyObject {
    // MARK: Callback methods from repository
}

final class JWTDecodeInteractor {
    // MARK: VIPER property

    weak var presenter: JWTDecodeInteractorOutput!

    // MARK: Stored instance properties

    // MARK: Computed instance properties

    // MARK: Initializer

    init() {}

    // MARK: Other private methods
}

extension JWTDecodeInteractor: JWTDecodeInteractorInput {}
