//
//  TextFormViewModel.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/03.
//

import Combine
import Reusable
import UIKit

class TextFormViewModel: Hashable, TextFormAvailable {
    static func == (lhs: TextFormViewModel, rhs: TextFormViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(textForm)
    }

    var textPublisher: Published<String?>.Publisher {
        return $text
    }

    @Published private(set) var text: String?
    private(set) var shuldFocusSubject = PassthroughSubject<Void, Never>()
    var textForm: TextForm
    var nextForm: TextFormAvailable?
    var previousForm: TextFormAvailable?
    var defaultString: String?
    var allowedStringHandler: ((String) -> Bool)?
    var formatHandler: ((String?) -> String?)?
    var validationHandler: ((String?) -> Error?)?
    private(set) var validationAppearance: TextValidationAppearance

    init(
        text: String?,
        textForm: TextForm,
        defaultString: String? = nil,
        allowedStringHandler: ((String) -> Bool)? = nil,
        formatHandler: ((String?) -> String?)? = nil,
        validationHandler: ((String?) -> Error?)? = nil,
        validationAppearance: TextValidationAppearance = StandartTextValidationAppearance(textColor: .systemRed)
    ) {
        self.text = text
        self.defaultString = defaultString
        self.textForm = textForm
        self.allowedStringHandler = allowedStringHandler
        self.formatHandler = formatHandler
        self.validationHandler = validationHandler
        self.validationAppearance = validationAppearance
    }

    @discardableResult
    func update(text: String?) -> String? {
        guard let text = text else {
            self.text = defaultString
            return self.text
        }
        guard let handler = formatHandler else {
            self.text = text
            return self.text
        }
        self.text = handler(text)
        return self.text
    }
}
