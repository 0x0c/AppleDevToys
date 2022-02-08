//
//  ConfigurationItem.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/03.
//

import Foundation

enum ConfigurationItem: Hashable {
    static func == (lhs: ConfigurationItem, rhs: ConfigurationItem) -> Bool {
        switch (lhs, rhs) {
        case let (.toggle(lhsValue), .toggle(rhsValue)):
            return lhsValue.hashValue == rhsValue.hashValue
        case let (.pulldownMenu(lhsValue), .pulldownMenu(rhsValue)):
            return lhsValue.title == rhsValue.title
        case (.toggle, .pulldownMenu):
            return false
        case (.pulldownMenu, .toggle):
            return false
        }
    }

    func hash(into hasher: inout Hasher) {
        switch self {
        case let .toggle(viewModel):
            hasher.combine(viewModel)
        case let .pulldownMenu(viewModel):
            hasher.combine(viewModel.title)
            hasher.combine(viewModel.detail)
            hasher.combine(viewModel.iconImage)
        }
    }

    case toggle(SwitchCellViewModel)
    case pulldownMenu(PulldownMenuViewModel)
}
