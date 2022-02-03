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
            SidebarSection(items: [.allTools]),
            SidebarSection(
                items: [
                    .jsonYamlConvert,
                    .numberBase
                ],
                headerTitle: "Converters"
            ),
            SidebarSection(
                items: [
                    .htmlEncodeDecode,
                    .urlEncodeDecode,
                    .base64EncodeDecode,
                    .jwtDecoder
                ],
                headerTitle: "Encoders / Decoders"
            ),
            SidebarSection(
                items: [
                    .jsonFormatter
                ],
                headerTitle: "Formatters"
            ),
            SidebarSection(
                items: [
                    .hashGenerator,
                    .uuidGenerator,
                    .loremIpsumGenerator
                ],
                headerTitle: "Generator"
            ),
            SidebarSection(
                items: [
                    .inspectorCaseConverter
                ],
                headerTitle: "Text"
            )
        ]
    }

    // MARK: Other private methods
}

extension SidebarInteractor: SidebarInteractorInput {}
