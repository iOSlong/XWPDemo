//
//  PDViewController.swift
//  XWPDemo
//
//  Created by xw.long on 2021/3/17.
//

import UIKit

class PDViewController: UIViewController {

    var backButton:UIButton?
    var rightButton:UIButton?
    var centerButton:UIButton?
    let backgroundImageView:UIImageView = {
        let imgv = UIImageView()
        return imgv
    }()
    
    private func quickButton(title:String,action:Selector) -> UIButton {
        let button = UIButton()
        button.addTarget(self, action:action, for: .touchUpInside)
        button.layer.cornerRadius = 4
        button.borderLine(color: .orange)
        button.setTitle(title, for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.backgroundImageView)
        self.backgroundImageView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(self.view.snp.edges)
        }
        // Do any additional setup after loading the view.
    }

    public func showNoneNavigationBackButton() {
        let backY = navigationSizeHeight() - 44.0
        self.backButton = self.quickButton(title: "返回", action: #selector(backButtonClick(_:)))
        self.backButton?.frame = CGRect.init(x: 15.0, y: Double(backY), width: 40.0, height: 44.0)
        self.view.addSubview(self.backButton!)
    }
    
    public func showRightButton(title:String) {
        let backY:Double = Double(navigationSizeHeight() - 44.0)
        let rightX:Double = Double(UIScreen.main.bounds.width - 55.0)
        self.rightButton = self.quickButton(title:title, action:#selector(rightButtonClick(_:)))
        self.rightButton?.frame = CGRect.init(x:rightX, y: backY, width: 40.0, height: 44.0)
        self.view.addSubview(self.rightButton!)
        self.rightButton?.snp.makeConstraints({ (maker) in
            maker.top.equalTo(backY)
            maker.right.equalTo(self.view.snp.right).offset(-15)
            maker.height.equalTo(40)
            maker.width.greaterThanOrEqualTo(40)
        })
    }
    
    public func showCenterButton(title:String) {
        let backY:Double = Double(navigationSizeHeight() - 44.0)
        let rightX:Double = Double(UIScreen.main.bounds.width * 0.5 - 30)
        self.centerButton = self.quickButton(title:title, action:#selector(centerButtonClick(_:)))
        self.centerButton?.frame = CGRect.init(x:rightX, y: backY, width: 60.0, height: 44.0)
        self.view.addSubview(self.centerButton!)
        self.centerButton?.snp.makeConstraints({ (maker) in
            maker.top.equalTo(backY)
            maker.centerX.equalTo(self.view.snp.centerX)
            maker.height.equalTo(40)
            maker.width.greaterThanOrEqualTo(40)
        })
    }
    
    
    @objc func rightButtonClick(_:UIButton) {
        print("子类具体实现")
    }
    
    @objc func centerButtonClick(_:UIButton) {
        print("子类具体实现")
    }

    @objc func backButtonClick(_:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
