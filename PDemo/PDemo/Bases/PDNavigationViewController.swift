//
//  PDNavigationViewController.swift
//  XWPDemo
//
//  Created by xw.long on 2021/3/17.
//

import UIKit

class PDNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置导航栏背景颜色
        self.navigationBar.barTintColor = .clear
        
        //标题颜色
        let dict:NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.orange,
                                 NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
        self.navigationBar.titleTextAttributes = (dict as! [NSAttributedString.Key : Any])
        
        //item颜色
        self.navigationBar.tintColor = UIColor.orange
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
