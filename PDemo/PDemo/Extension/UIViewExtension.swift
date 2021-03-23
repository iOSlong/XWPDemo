//
//  UIViewExtension.swift
//  PDemo
//
//  Created by xw.long on 2021/3/18.
//

import Foundation
import UIKit
import SwiftyJSON

extension UIView {
    func borderLine(color:UIColor) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1
    }
    
    func layoutInfo() -> String {
        let transF = self.transform;
        let frame = self.frame;
        let infoString = "transF:{a:\(transF.a) b:\(transF.b) c:\(transF.c) d:\(transF.d) tx:\(transF.tx) ty:\(transF.ty)},frame:{\(frame.origin.x) \(frame.origin.y) \(frame.width) \(frame.height)}"
        return infoString
    }
    
    static func PDLabel(textColor:UIColor?,font:UIFont?) -> UILabel {
        let label = UILabel()
        label.font = font ?? UIFont.italicSystemFont(ofSize: 12)
        label.textColor = textColor ?? .white
        label.numberOfLines = 0
        return label
    }
}
