//
//  PulldownSelectableItemViewModel.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/04.
//

import Combine
import UIKit

protocol PulldownableItem {
    func title() -> String
}

class PulldownSelectableItemViewModel<Value: PulldownableItem> {
    let title: String
    let iconImage: UIImage
    let selectableItems: [Value]
    @Published var selectedItem: Value?

    init(title: String, iconImage: UIImage, selectableItems: [Value], initialSelection: Value? = nil) {
        self.title = title
        self.iconImage = iconImage
        self.selectableItems = selectableItems
        selectedItem = initialSelection
    }

    func currentSelectionTitle() -> String? {
        guard let selectedItemPublisher = selectedItem else {
            return nil
        }
        return selectedItemPublisher.title()
    }
}
