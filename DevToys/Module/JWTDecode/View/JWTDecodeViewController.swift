//
//  JWTDecodeViewController.swift
//  DevToys
//
//  Created by Akira on 04/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import Highlightr
import JWTDecode
import UIKit

protocol JWTDecodeViewInput: AnyObject {
    // MARK: Callback from presenter
}

final class JWTDecodeViewController: UIViewController {
    // MARK: Stored instance properties

    var presenter: JWTDecodePresenterInput!

    // MARK: Computed instance properties

    // MARK: IBOutlets

    @IBOutlet private var jwtTokenTextView: UITextView!
    @IBOutlet private var headeTextView: UITextView!
    @IBOutlet private var payloadTextView: UITextView!
    @IBOutlet private var signatureTextView: UITextView!

    @IBOutlet private var jwtTokenTextViewBaseView: UIView!
    @IBOutlet private var headerTextViewBaseView: UIView!
    @IBOutlet private var payloadTextViewBaseView: UIView!
    @IBOutlet private var signatureTextViewBaseView: UIView!

    private var highlightr: Highlightr! {
        let highlightr = Highlightr()
        highlightr!.setTheme(to: "paraiso-dark")
        highlightr!.theme.setCodeFont(.monospacedSystemFont(ofSize: 12, weight: .regular))
        return highlightr
    }

    // MARK: View Life-Cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "JWT Decode"
        jwtTokenTextView.delegate = self
        jwtTokenTextViewBaseView.layer.cornerRadius = Constant.defaultCornerRadius
        headerTextViewBaseView.layer.cornerRadius = Constant.defaultCornerRadius
        payloadTextViewBaseView.layer.cornerRadius = Constant.defaultCornerRadius
        signatureTextViewBaseView.layer.cornerRadius = Constant.defaultCornerRadius
        presenter.viewDidLoad()
    }

    // MARK: Other private methods
}

extension JWTDecodeViewController: JWTDecodeViewInput {}

extension JWTDecodeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        do {
            let jwt = try decode(jwt: textView.text)
            let headerObject = try JSONSerialization.data(
                withJSONObject: jwt.header,
                options: [.prettyPrinted, .sortedKeys]
            )
            if let text = String(bytes: headerObject, encoding: .utf8) {
                headeTextView.attributedText = highlightr.highlight(text, as: "javascript")
            }

            let bodyObject = try JSONSerialization.data(
                withJSONObject: jwt.body,
                options: [.prettyPrinted, .sortedKeys]
            )
            if let text = String(bytes: bodyObject, encoding: .utf8) {
                payloadTextView.attributedText = highlightr.highlight(text, as: "javascript")
            }
            signatureTextView.text = jwt.signature
        }
        catch {
            headeTextView.text = nil
            payloadTextView.text = nil
            signatureTextView.text = nil
        }
    }
}
