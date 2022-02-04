//
//  InputNumberTypeSelectionCellViewModel.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/04.
//

import Combine
import UIKit

extension InputNumberType: PulldownableItem {
    func title() -> String {
        return rawValue
    }
}

class InputNumberTypeSelectionCellViewModel: PulldownSelectableItemViewModel<InputNumberType>, Hashable {
    static func == (lhs: InputNumberTypeSelectionCellViewModel, rhs: InputNumberTypeSelectionCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(detail)
    }

    let detail: String

    init() {
        detail = "Select which type you want to use"
        super.init(
            title: "Input type",
            iconImage: UIImage(systemSymbol: .arrowLeftArrowRight),
            selectableItems: InputNumberType.allCases,
            initialSelection: .decimal
        )
    }
}
