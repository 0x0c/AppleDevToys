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
