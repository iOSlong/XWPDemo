//
//  PDVCUtil.swift
//  PDemo
//
//  Created by xw.long on 2021/3/18.
//

import Foundation
import UIKit

class PDVCUtil {
    static func viewControllerFromName(vcName:String) -> UIViewController? {
        // 1. 获取去命名空间,由于项目肯定有info.plist文件所有可以机型强制解包.
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            NSLog("没有获取到命名空间")
            return nil
        }
        
        // 2. 根据类名获取对应的类
        guard let childVcClass = NSClassFromString("\(nameSpace).\(vcName)") else {
            NSLog("没有获取到对应的类")
            return nil
        }
        // 3. 将AnyObject转换成控制器类型
        guard let childVcType = childVcClass as? UIViewController.Type else {
            NSLog("没有转换成控制器类型")
            return nil
        }
        // 3. 创建控制器实例
        let childVc = childVcType.init()
        return childVc
    }
}
