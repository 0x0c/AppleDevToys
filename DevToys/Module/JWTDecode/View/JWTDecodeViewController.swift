//
//  JWTDecodeViewController.swift
//  DevToys
//
//  Created by Akira on 04/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import Drops
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

    @IBOutlet private var backgroundViews: [UIView]!

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
        jwtTokenTextView.font = .monospacedSystemFont(ofSize: 14, weight: .regular)
        jwtTokenTextView.delegate = self
        backgroundViews.forEach {
            $0.layer.cornerRadius = Constant.defaultCornerRadius
        }
        presenter.viewDidLoad()
    }

    // MARK: Other private methods

    @IBAction private func didPasteButtonPress(_ sender: Any) {
        if let text = UIPasteboard.general.value(forPasteboardType: "public.text") as? String {
            jwtTokenTextView.text = text
            decodeToken(jwtTokenTextView.text)
            Drops.hideAll()
            Drops.show("Pasted!")
        }
    }

    @IBAction private func didCopyHeaderButtonPress(_ sender: Any) {
        if let text = headeTextView.text {
            UIPasteboard.general.setValue(text, forPasteboardType: "public.text")
            Drops.hideAll()
            Drops.show("Copied!")
        }
    }

    @IBAction private func didCopyPayloadButtonPress(_ sender: Any) {
        if let text = payloadTextView.text {
            UIPasteboard.general.setValue(text, forPasteboardType: "public.text")
            Drops.hideAll()
            Drops.show("Copied!")
        }
    }

    @IBAction private func didCopySignatureButtonPress(_ sender: Any) {
        if let text = signatureTextView.text {
            UIPasteboard.general.setValue(text, forPasteboardType: "public.text")
            Drops.hideAll()
            Drops.show("Copied!")
        }
    }

    private func decodeToken(_ string: String) {
        do {
            let jwt = try decode(jwt: string)
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
            headeTextView.text = "[Decode error]"
            payloadTextView.text = "[Decode error]"
            signatureTextView.text = "[Decode error]"
        }
    }
}

extension JWTDecodeViewController: JWTDecodeViewInput {}

extension JWTDecodeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        decodeToken(textView.text)
    }
}
