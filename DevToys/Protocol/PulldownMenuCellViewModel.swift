//
//  PulldownSelectableItemViewModel.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/04.
//

import Combine
import UIKit

protocol PulldownableItem: CaseIterable, RawRepresentable where RawValue == String {
    func title() -> String
}

protocol PulldownMenuViewModel {
    var title: String? { get }
    var detail: String? { get }
    var iconImage: UIImage? { get }

    func selectedItemTitle() -> String?
    func menuTitles() -> [String]
    func updateMenu(for title: String?)
}

class PulldownMenuCellViewModel<Value: PulldownableItem>: PulldownMenuViewModel {
    let title: String?
    let detail: String?
    let iconImage: UIImage?
    let selectableItems: [Value]
    @Published var selectedItem: Value?

    init(title: String?, detail: String?, iconImage: UIImage, selectableItems: [Value], initialSelection: Value? = nil) {
        self.title = title
        self.detail = detail
        self.iconImage = iconImage
        self.selectableItems = selectableItems
        selectedItem = initialSelection
    }

    func selectedItemTitle() -> String? {
        return selectedItem?.title()
    }

    func menuTitles() -> [String] {
        return Value.allCases.map(\.rawValue)
    }

    func updateMenu(for title: String?) {
        guard let title = title else {
            return
        }
        selectedItem = Value(rawValue: title)
    }
}
