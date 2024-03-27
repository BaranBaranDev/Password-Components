//
//  UIStackView+Ext.swift
//  Password-Components
//
//  Created by Baran Baran on 21.03.2024.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}
