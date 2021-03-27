//
//  PDZoomScrollViewController.swift
//  PDemo
//
//  Created by xw.long on 2021/3/18.
//

import UIKit

class PDZoomScrollViewController: PDViewController {
    var photoDismissWithSelectedImage:PDPhotoListSelected?

    var zoomSV:PDZoomScrollView = {
        let zoomv = PDZoomScrollView.init(frame:UIScreen.main.bounds)
        return zoomv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.zoomSV)

        self.showNoneNavigationBackButton()
        self.showRightButton(title: "PickImg")
        // Do any additional setup after loading the view.
    }
    
    override func rightButtonClick(_: UIButton) {
        let photoListVC = PDPhotoListViewController()
        self.present(photoListVC, animated: true, completion: nil)
      
        photoListVC.photoDismissWithSelectedImage = {[weak self] (imagePath) -> Void in
            guard let this = self else { return }
            let demoImage = PDFileUtil.image(imagePath: imagePath)
            if demoImage != nil {
                this.zoomSV.loadDemoImage(demoImage: demoImage! )
            }
        }
    }
}
