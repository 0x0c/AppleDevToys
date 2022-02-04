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

    private var inputNumberTypeSelection = InputNumberTypeSelectionCellViewModel()
    private var inputTextForm = InputNumberTextFormViewModel()
    private var decimalTextForm = DecimalTextFormViewModel(isEditable: false)
    private var hexTextForm = HexadecimalTextFormViewModel(isEditable: false)
    private var octalTextForm = OctalTextFormViewModel(isEditable: false)
    private var binaryTextForm = BinaryTextFormViewModel(isEditable: false)

    private var isUpdating = false

    private var formatEnabled = SwitchCellViewModel(
        title: "Format number",
        image: UIImage(systemSymbol: .textformat123)
    )
    private var uppercaseEnabled = SwitchCellViewModel(
        title: "Uppercase",
        image: UIImage(systemSymbol: .textformat)
    )

    // MARK: Computed instance properties

    // MARK: Initializer

    init() {
        sections = [
            ConfigurationSection(items: [
                .toggle(formatEnabled),
                .toggle(uppercaseEnabled),
                .inputNumberType(inputNumberTypeSelection)
            ]),
            NumberInputFormSection.form([
                inputTextForm
            ], headerTitle: "Input"),
            NumberInputFormSection.form([
                decimalTextForm
            ], headerTitle: "Decimal"),
            NumberInputFormSection.form([
                hexTextForm
            ], headerTitle: "Hex"),
            NumberInputFormSection.form([
                octalTextForm
            ], headerTitle: "Octal"),
            NumberInputFormSection.form([
                binaryTextForm
            ], headerTitle: "Binary")
        ]
        inputNumberTypeSelection.$selectedItem.sink { [unowned self] value in
            self.inputTextForm.selectedItem = value
            self.inputTextForm.update(text: "0")
        }.store(in: &cancellable)
        inputTextForm.$text.removeDuplicates().sink { [unowned self] text in
            guard let value = self.inputNumberTypeSelection.selectedItem else {
                return
            }
            self.update(
                text,
                radix: value.radix(),
                format: self.formatEnabled.isOn,
                uppercase: self.uppercaseEnabled.isOn
            )
        }.store(in: &cancellable)

        formatEnabled.$isOn.sink { [unowned self] enabled in
            self.decimalTextForm.formatText = enabled
            self.hexTextForm.formatText = enabled
            self.octalTextForm.formatText = enabled
            self.binaryTextForm.formatText = enabled
            self.reload(format: enabled, uppercase: self.uppercaseEnabled.isOn)
        }.store(in: &cancellable)
        uppercaseEnabled.$isOn.sink { [unowned self] enabled in
            self.hexTextForm.uppercase = enabled
            self.reload(format: self.formatEnabled.isOn, uppercase: enabled)
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
              let integer = Int(pureString, radix: radix) else {
            isUpdating = false
            return
        }
        inputTextForm.update(text: integer.stringfy(radix: radix))
        decimalTextForm.update(text: integer.stringfy(radix: 10, format: format))
        hexTextForm.update(text: integer.stringfy(radix: 16, format: format))
        octalTextForm.update(text: integer.stringfy(radix: 8, format: format))
        binaryTextForm.update(text: integer.stringfy(radix: 2, format: format))
        isUpdating = false
    }

    private func reload(format: Bool, uppercase: Bool) {
        guard let value = inputNumberTypeSelection.selectedItem else {
            return
        }
        update(
            inputTextForm.text,
            radix: value.radix(),
            format: format,
            uppercase: uppercase
        )
    }
}

extension NumberBaseInteractor: NumberBaseInteractorInput {}
