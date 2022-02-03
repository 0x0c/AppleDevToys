//
//  NumberBaseInteractor.swift
//  DevToys
//
//  Created by Akira on 03/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import Combine
import CompositionalLayoutViewController
import CompositionalLayoutViewControllerViperExtension
import Foundation

protocol NumberBaseInteractorInput: CollectionViewInteractorInput {
    // MARK: Methods for modifying repository
}

protocol NumberBaseInteractorOutput: AnyObject {
    // MARK: Callback methods from repository
}

final class NumberBaseInteractor {
    // MARK: VIPER property

    weak var presenter: NumberBaseInteractorOutput!

    // MARK: Stored instance properties

    var sections: [CollectionViewSection] = []
    private var cancellable = Set<AnyCancellable>()

    private lazy var decimalTextFormViewModel = DecimalTextFormViewModel()
    private lazy var hexTextFormViewModel = HexadecimalTextFormViewModel()
    private lazy var octalTextFormViewModel = OctalTextFormViewModel()
    private lazy var binaryTextFormViewModel = BinaryTextFormViewModel()

    private var isUpdating = false

    private var formatEnabledViewModel = SwitchCellViewModel(
        title: "Format number",
        image: UIImage(systemSymbol: .textformat123)
    )
    private var uppercaseEnabledViewModel = SwitchCellViewModel(
        title: "Uppercase",
        image: UIImage(systemSymbol: .textformat)
    )
    // MARK: Computed instance properties

    // MARK: Initializer

    init() {
        sections = [
            ConfigurationSection(items: [
                .toggle(formatEnabledViewModel),
                .toggle(uppercaseEnabledViewModel)
            ]),
            TextFormSection.form([
                decimalTextFormViewModel,
                hexTextFormViewModel,
                octalTextFormViewModel,
                binaryTextFormViewModel
            ], cellHeight: 30)
        ]

        decimalTextFormViewModel.$text.removeDuplicates().sink { [unowned self] text in
            self.update(
                text,
                radix: 10,
                format: self.formatEnabledViewModel.isOn,
                uppercase: uppercaseEnabledViewModel.isOn
            )
        }.store(in: &cancellable)
        hexTextFormViewModel.$text.removeDuplicates().sink { [unowned self] text in
            self.update(
                text,
                radix: 16,
                format: self.formatEnabledViewModel.isOn,
                uppercase: uppercaseEnabledViewModel.isOn
            )
        }.store(in: &cancellable)
        octalTextFormViewModel.$text.removeDuplicates().sink { [unowned self] text in
            self.update(
                text,
                radix: 8,
                format: self.formatEnabledViewModel.isOn,
                uppercase: uppercaseEnabledViewModel.isOn
            )
        }.store(in: &cancellable)
        binaryTextFormViewModel.$text.removeDuplicates().sink { [unowned self] text in
            self.update(
                text,
                radix: 2,
                format: self.formatEnabledViewModel.isOn,
                uppercase: uppercaseEnabledViewModel.isOn
            )
        }.store(in: &cancellable)

        formatEnabledViewModel.$isOn.sink { [unowned self] enabled in
            self.decimalTextFormViewModel.formatText = enabled
            self.hexTextFormViewModel.formatText = enabled
            self.octalTextFormViewModel.formatText = enabled
            self.binaryTextFormViewModel.formatText = enabled
            self.reload(format: enabled, uppercase: self.uppercaseEnabledViewModel.isOn)
        }.store(in: &cancellable)
        uppercaseEnabledViewModel.$isOn.sink { [unowned self] enabled in
            self.hexTextFormViewModel.uppercase = enabled
            self.reload(format: self.formatEnabledViewModel.isOn, uppercase: enabled)
        }.store(in: &cancellable)
    }

    // MARK: Other private methods
    private func update(_ text: String?, radix: Int, format: Bool, uppercase: Bool) {
        if isUpdating {
            return
        }
        isUpdating = true

        guard let text = text,
            let pureString = text.purify(radix: radix),
            let integer = Int(pureString, radix: radix)
        else {
            isUpdating = false
            return
        }
        decimalTextFormViewModel.update(text: integer.stringfy(radix: 10, format: format))
        hexTextFormViewModel.update(text: integer.stringfy(radix: 16, format: format))
        octalTextFormViewModel.update(text: integer.stringfy(radix: 8, format: format))
        binaryTextFormViewModel.update(text: integer.stringfy(radix: 2, format: format))
        isUpdating = false
    }

    private func reload(format: Bool, uppercase: Bool) {
        update(
            decimalTextFormViewModel.text,
            radix: 10,
            format: format,
            uppercase: uppercase
        )
    }
}

extension NumberBaseInteractor: NumberBaseInteractorInput {}
