//
//  TextForm.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/03.
//

import UIKit

struct TextForm: Hashable {
    var placeholder: String?
    var isEditable = true
    var isSecureTextEntry = false
    var keyboardType: UIKeyboardType = .default
    var spellCheckingType: UITextSpellCheckingType = .default
    var autocorrectionType: UITextAutocorrectionType = .default
    var autocapitalizationType: UITextAutocapitalizationType = .sentences
    var contentType: UITextContentType?
    var passwordRules: UITextInputPasswordRules?
}
