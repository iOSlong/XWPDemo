//
//  PDLargeImageViewController.swift
//  PDemo
//
//  Created by xw.long on 2021/5/18.
//

import UIKit

class PDLargeImageViewController: PDViewController {
    deinit {
        print("释放掉了")
    }
    
    var zoomSV:PDZoomScrollView = {
        let zoomv = PDZoomScrollView.init(frame:CGRect(x: 50, y: 100, width: 300, height: UIScreen.main.bounds.height - 120));
        zoomv.borderLine(color: .orange)
        return zoomv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        self.showNoneNavigationBackButton()
        self.showRightButton(title: "picker")
        self.view.borderLine(color: .orange)
        self.view.addSubview(self.zoomSV)
    }
    
    override func rightButtonClick(_: UIButton) {
        var imgDemo = PDImgDemo("8.3","jpg")
//         imgDemo = PDImgDemo("90","jpg")
         imgDemo = PDImgDemo("40","jpg")
        var pickImg:UIImage = UIImage.init(named: "sageAlliance.jpg")!
        pickImg = UIImage.init(named: imgDemo.fullName)!
//        let imgDemo = imgDemos[3]
        
        //下面这个方法获得图片，无法通过memorySizeWithImage方法计算出图片内存占用大小。
        let imgURL = PDFileUtil.fileURL(fileName: imgDemo.name, type: imgDemo.type)
        let ciImg = CIImage.init(contentsOf: imgURL!)
        let demoImage = UIImage.init(ciImage: ciImg!)
        let imgSize2 = PDFileUtil.memorySizeWithImage(image: demoImage)

        let imgSize = PDFileUtil.memorySizeWithImage(image: pickImg)

        if imgSize > 100 * (1024 * 1024) {
            
        }
        self.zoomSV.loadDemoImage(demoImage: pickImg)
    }
    
}
