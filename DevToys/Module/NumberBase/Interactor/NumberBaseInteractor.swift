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

    private lazy var decimalTextFormViewModel = TextFormViewModel(
        text: "0",
        textForm: TextForm(
            placeholder: "Decimal"
        ),
        defaultString: "0",
        allowedStringHandler: { string in
            if string == "00" {
                return false
            }
            return string.purify(radix: 10)?.toInteger(radix: 10) != nil
        },
        formatHandler: { [unowned self] string in
            if var ss = string, let char = ss.first, char == "0" {
                return String(ss.removeLast())
            }
            let str = string?.purify(radix: 10)
            if self.formatEnabledViewModel.isOn {
                return str?.formatted(radix: 10)
            }
            return str
        }
    )

    private lazy var hexTextFormViewModel = TextFormViewModel(
        text: "0",
        textForm: TextForm(
            placeholder: "Hex"
        ),
        defaultString: "0",
        allowedStringHandler: { string in
            if string == "00" {
                return false
            }
            return string.purify(radix: 16)?.toInteger(radix: 16) != nil
        },
        formatHandler: { [unowned self] string in
            if var ss = string, let char = ss.first, char == "0" {
                return String(ss.removeLast())
            }
            var numberString: String? {
                if self.uppercaseEnabledViewModel.isOn {
                    return string?.uppercased()
                }
                return string?.lowercased()
            }
            let str = numberString?.purify(radix: 16)
            if self.formatEnabledViewModel.isOn {
                return str?.formatted(radix: 16)
            }
            return str
        }
    )

    private lazy var octalTextFormViewModel = TextFormViewModel(
        text: "0",
        textForm: TextForm(
            placeholder: "Octal"
        ),
        defaultString: "0",
        allowedStringHandler: { string in
            if string == "00" {
                return false
            }
            return string.purify(radix: 8)?.toInteger(radix: 8) != nil
        },
        formatHandler: { [unowned self] string in
            if var ss = string, let char = ss.first, char == "0" {
                return String(ss.removeLast())
            }
            let str = string?.purify(radix: 8)
            if self.formatEnabledViewModel.isOn {
                return str?.formatted(radix: 8)
            }
            return str
        }
    )

    private lazy var binaryTextFormViewModel = TextFormViewModel(
        text: "0",
        textForm: TextForm(
            placeholder: "Binary"
        ),
        defaultString: "0",
        allowedStringHandler: { string in
            return string.purify(radix: 2)?.toInteger(radix: 2) != nil
        },
        formatHandler: { [unowned self] string in
            let str = string?.purify(radix: 2)
            if self.formatEnabledViewModel.isOn {
                return str?.formatted(radix: 2)
            }
            return str
        }
    )
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
            self.reload(format: enabled, uppercase: self.uppercaseEnabledViewModel.isOn)
        }.store(in: &cancellable)
        uppercaseEnabledViewModel.$isOn.sink { [unowned self] enabled in
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
            let integer = Int(pureString)
        else {
            isUpdating = false
            return
        }
        decimalTextFormViewModel.text = integer.stringfy(radix: 10, format: format)
        var hexString: String? {
            let str = integer.stringfy(radix: 16, format: format)
            if uppercase {
                return str?.uppercased()
            }
            return str?.lowercased()
        }
        hexTextFormViewModel.text = hexString
        octalTextFormViewModel.text = integer.stringfy(radix: 8, format: format)
        binaryTextFormViewModel.text = integer.stringfy(radix: 2, format: format)
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
