//
//  UIButton + Ext.swift
//  Firebase_Tasks
//
//  Created by Vitali Martsinovich on 2023-06-08.
//

import UIKit

extension UIButton {
    
    convenience init(target: Any?, action: Selector) {
        self.init(type: .system)
        self.setImage(AuthConstant.Symbol.seePassword, for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        self.addTarget(target, action: action, for: .touchUpInside)
        self.tintColor = CommonConstant.Color.lightGray
//        self.heightAnchor.constraint(equalToConstant: 15).isActive = true
//        self.widthAnchor.constraint(equalToConstant: 15).isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

