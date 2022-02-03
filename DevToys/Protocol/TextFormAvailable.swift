//
//  TextFormAvailable.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/03.
//

import Combine
import Reusable
import UIKit

extension Array where Element == TextFormAvailable {
    func link() {
        var iterator = makeIterator()
        var current: TextFormAvailable? = iterator.next()
        var previous: TextFormAvailable?
        while let next = iterator.next() {
            current?.previousForm = previous
            current?.nextForm = next
            previous = current
            current = next
        }
    }
}

protocol TextValidationAppearance {
    func textColor(for error: Error) -> UIColor
    func errorTextColor(for error: Error) -> UIColor
}

struct StandartTextValidationAppearance: TextValidationAppearance {
    let textColor: UIColor

    func textColor(for error: Error) -> UIColor {
        return textColor
    }

    func errorTextColor(for error: Error) -> UIColor {
        return textColor
    }
}

protocol TextFormAvailable {
    var textPublisher: Published<String?>.Publisher { get }
    var textForm: TextForm { get set }
    var nextForm: TextFormAvailable? { get set }
    var previousForm: TextFormAvailable? { get set }
    var shuldFocusSubject: PassthroughSubject<Void, Never> { get }
    var validationHandler: ((String?) -> Error?)? { get }
    var validationAppearance: TextValidationAppearance { get }

    func dequeueCell(_ collectionView: UICollectionView, for indexPath: IndexPath) -> (UICollectionViewCell & TextFormCellProtocol)
    func registerCell(_ collection: UICollectionView)
    func focusNext() -> Bool
    func focusPrevious() -> Bool
}

extension TextFormAvailable {
    func dequeueCell(_ collectionView: UICollectionView, for indexPath: IndexPath) -> (UICollectionViewCell & TextFormCellProtocol) {
        return collectionView.dequeueReusableCell(for: indexPath, cellType: TextFormCell.self)
    }

    func registerCell(_ collectionView: UICollectionView) {
        return collectionView.register(cellType: TextFormCell.self)
    }

    @discardableResult
    func focusNext() -> Bool {
        nextForm?.shuldFocusSubject.send(())
        guard let form = nextForm else {
            return false
        }
        form.shuldFocusSubject.send(())
        return true
    }

    @discardableResult
    func focusPrevious() -> Bool {
        guard let form = previousForm else {
            return false
        }
        form.shuldFocusSubject.send(())
        return true
    }
}
