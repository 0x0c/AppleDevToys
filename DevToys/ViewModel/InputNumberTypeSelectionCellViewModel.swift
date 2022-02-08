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

class InputNumberTypeSelectionCellViewModel: PulldownMenuCellViewModel<InputNumberType>, Hashable {
    static func == (lhs: InputNumberTypeSelectionCellViewModel, rhs: InputNumberTypeSelectionCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(detail)
    }

    init() {
        super.init(
            title: "Input type",
            detail: "Select which type you want to use",
            iconImage: UIImage(systemSymbol: .arrowLeftArrowRight),
            selectableItems: InputNumberType.allCases,
            initialSelection: .decimal
        )
    }
}
