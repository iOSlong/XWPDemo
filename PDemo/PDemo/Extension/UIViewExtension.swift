//
//  UIViewExtension.swift
//  PDemo
//
//  Created by xw.long on 2021/3/18.
//

import Foundation
import UIKit

extension UIView {
    func borderLine(color:UIColor) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1
    }
}
