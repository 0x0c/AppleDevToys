//
//  SidebarInteractor.swift
//  DevToys
//
//  Created by Akira on 03/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import CompositionalLayoutViewController
import CompositionalLayoutViewControllerViperExtension
import Foundation
import SFSafeSymbols

protocol SidebarInteractorInput: CollectionViewInteractorInput {
    // MARK: Methods for modifying repository
}

protocol SidebarInteractorOutput: AnyObject {
    // MARK: Callback methods from repository
}

final class SidebarInteractor {
    // MARK: VIPER property

    weak var presenter: SidebarInteractorOutput!

    // MARK: Stored instance properties
    var sections: [CollectionViewSection] = []

    // MARK: Computed instance properties

    // MARK: Initializer

    init() {
        sections = [
            SidebarSection(
                items: [
                    .header("Converters"),
                    .jsonYamlConvert,
                    .numberBase
                ]
            ),
            SidebarSection(
                items: [
                    .header("Encoders / Decoders"),
                    .htmlEncodeDecode,
                    .urlEncodeDecode,
                    .base64EncodeDecode,
                    .jwtDecoder
                ]
            ),
            SidebarSection(
                items: [
                    .header("Formatters"),
                    .jsonFormatter
                ]
            ),
            SidebarSection(
                items: [
                    .header("Generator"),
                    .hashGenerator,
                    .uuidGenerator,
                    .loremIpsumGenerator
                ]
            ),
            SidebarSection(
                items: [
                    .header("Text"),
                    .inspectorCaseConverter
                ]
            )
        ]
    }

    // MARK: Other private methods
}

extension SidebarInteractor: SidebarInteractorInput {}
