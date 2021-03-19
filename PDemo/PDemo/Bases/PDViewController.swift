//
//  PDViewController.swift
//  XWPDemo
//
//  Created by xw.long on 2021/3/17.
//

import UIKit

class PDViewController: UIViewController {

    var backButton:UIButton?
    var resetButton:UIButton?
    var infoButton:UIButton?
    
    private func quickButton(title:String,action:Selector) -> UIButton {
        let button = UIButton()
        button.addTarget(self, action:action, for: .touchUpInside)
        button.layer.cornerRadius = 4
        button.borderLine(color: .blue)
        button.setTitle(title, for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    public func showNoneNavigationBackButton() {
        let backY = navigationSizeHeight() - 44.0
        self.backButton = self.quickButton(title: "返回", action: #selector(backButtonClick(_:)))
        self.backButton?.frame = CGRect.init(x: 15.0, y: Double(backY), width: 40.0, height: 44.0)
        self.view.addSubview(self.backButton!)
    }
    
    public func showResetButton() {
        let backY:Double = Double(navigationSizeHeight() - 44.0)
        let rightX:Double = Double(UIScreen.main.bounds.width - 55.0)
        self.resetButton = self.quickButton(title:"复位", action:#selector(resetButtonClick(_:)))
        self.resetButton?.frame = CGRect.init(x:rightX, y: backY, width: 40.0, height: 44.0)
        self.view.addSubview(self.resetButton!)
    }
    
    public func showLogInfoButton() {
        let backY:Double = Double(navigationSizeHeight() - 44.0)
        let rightX:Double = Double(UIScreen.main.bounds.width * 0.5 - 30)
        self.infoButton = self.quickButton(title:"日志Info", action:#selector(logInfoButtonClick(_:)))
        self.infoButton?.frame = CGRect.init(x:rightX, y: backY, width: 60.0, height: 44.0)
        self.view.addSubview(self.infoButton!)
    }
    
    
    @objc func resetButtonClick(_:UIButton) {
        
    }
    
    @objc func logInfoButtonClick(_:UIButton) {
        
    }

    @objc func backButtonClick(_:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
