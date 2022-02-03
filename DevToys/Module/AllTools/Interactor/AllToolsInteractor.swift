//
//  AllToolsInteractor.swift
//  DevToys
//
//  Created by Akira on 03/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import CompositionalLayoutViewController
import CompositionalLayoutViewControllerViperExtension
import Foundation

protocol AllToolsInteractorInput: CollectionViewInteractorInput {
    // MARK: Methods for modifying repository
}

protocol AllToolsInteractorOutput: AnyObject {
    // MARK: Callback methods from repository
}

final class AllToolsInteractor {
    // MARK: VIPER property

    weak var presenter: AllToolsInteractorOutput!

    // MARK: Stored instance properties

    var sections: [CollectionViewSection] = []

    // MARK: Computed instance properties

    // MARK: Initializer

    init() {}

    // MARK: Other private methods
}

extension AllToolsInteractor: AllToolsInteractorInput {}
