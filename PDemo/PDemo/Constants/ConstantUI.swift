//
//  ConstantUI.swift
//  XWPDemo
//
//  Created by xw.long on 2021/3/17.
//

import Foundation
import UIKit

func isBangsScreen() -> Bool {
    let applegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let window:UIWindow = applegate.window ?? UIWindow()
    if #available(iOS 11.0, *) {
        let res:Bool = window.safeAreaInsets.bottom > 0
        return res
    } else {
        return false;
    }
}

func navigationSizeHeight() -> Float {
    if isBangsScreen() {
        return 88.0
    }
    return 64.0
}

func tabSizeHeight() -> Float {
    if isBangsScreen() {
        return 83.0;
    }
    return 49.0
}
