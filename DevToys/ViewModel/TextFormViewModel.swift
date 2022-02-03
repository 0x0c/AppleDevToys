//
//  TextFormViewModel.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/03.
//

import Combine
import Reusable
import UIKit

final class TextFormViewModel: Hashable, TextFormAvailable {
    static func == (lhs: TextFormViewModel, rhs: TextFormViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(textForm)
    }

    var textPublisher: Published<String?>.Publisher {
        return $text
    }

    @Published var text: String?
    var textForm: TextForm
    var nextForm: TextFormAvailable?
    var previousForm: TextFormAvailable?
    var defaultString: String?
    private(set) var shuldFocusSubject = PassthroughSubject<Void, Never>()
    private(set) var allowedStringHandler: ((String) -> Bool)?
    private(set) var formatHandler: ((String?) -> String?)?
    private(set) var validationHandler: ((String?) -> Error?)?
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
}
