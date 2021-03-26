//
//  AppDelegate.swift
//  PDemo
//
//  Created by xw.long on 2021/3/18.
//

/*
 注意：
 1. 添加成员变量window：UIWindow
 */

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
        self.window = UIWindow.init(frame:UIScreen.main.bounds)
//        self.window?.backgroundColor = .black
        self.window?.makeKeyAndVisible()//可有可无。

        let listUI = PDUICaseViewController()
        listUI.title = "User interface"

        let listNet = PDTableViewController()
        listNet.title = "Net"


        let naviUI = PDNavigationViewController.init(rootViewController: listUI)
        let naviNet = PDNavigationViewController.init(rootViewController: listNet)

        let tabBC = UITabBarController()
        tabBC.tabBar.barTintColor = .clear
        tabBC.viewControllers = [naviUI,naviNet]
        self.window?.rootViewController = tabBC
        return true
    }
}
