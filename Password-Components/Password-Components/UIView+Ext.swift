//
//  UIView+Ext.swift
//  Password-Components
//
//  Created by Baran Baran on 21.03.2024.
//

import UIKit


extension UIView {
    func addSubviews(_ views: [UIView] ){
        views.forEach { addSubview($0)}
    }
}
