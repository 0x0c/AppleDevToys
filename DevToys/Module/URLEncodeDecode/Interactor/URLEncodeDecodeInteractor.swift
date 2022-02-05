//
//  URLInteractor.swift
//  DevToys
//
//  Created by Akira on 05/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import Foundation

protocol URLEncodeDecodeInteractorInput: AnyObject {
    // MARK: Methods for modifying repository
}

protocol URLEncodeDecodeInteractorOutput: AnyObject {
    // MARK: Callback methods from repository
}

final class URLEncodeDecodeInteractor {
    // MARK: VIPER property

    weak var presenter: URLEncodeDecodeInteractorOutput!

    // MARK: Stored instance properties

    // MARK: Computed instance properties

    // MARK: Initializer

    init() {}

    // MARK: Other private methods
}

extension URLEncodeDecodeInteractor: URLEncodeDecodeInteractorInput {}
