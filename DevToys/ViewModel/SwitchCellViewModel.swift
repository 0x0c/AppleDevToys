//
//  SwitchCellViewModel.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/03.
//

import Combine
import Foundation
import UIKit

final class SwitchCellViewModel: Hashable {
    static func == (lhs: SwitchCellViewModel, rhs: SwitchCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }

    var title: String?
    var image: UIImage?
    @Published var isOn: Bool

    init(title: String?, image: UIImage? = nil, isOn: Bool = false) {
        self.title = title
        self.image = image
        self.isOn = isOn
    }
}
