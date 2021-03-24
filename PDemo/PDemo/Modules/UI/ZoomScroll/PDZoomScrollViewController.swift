//
//  PDZoomScrollViewController.swift
//  PDemo
//
//  Created by xw.long on 2021/3/18.
//

import UIKit

class PDZoomScrollViewController: PDViewController {
    var zoomSV:PDZoomScrollView = {
        let zoomv = PDZoomScrollView.init(frame:UIScreen.main.bounds)
        return zoomv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        self.view.addSubview(self.zoomSV)

        self.showNoneNavigationBackButton()
        // Do any additional setup after loading the view.
    }
}
