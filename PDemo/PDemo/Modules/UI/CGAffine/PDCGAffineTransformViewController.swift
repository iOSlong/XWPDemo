//
//  PDCGAffineTransformViewController.swift
//  XWPDemo
//
//  Created by xw.long on 2021/3/17.
//

import UIKit



class PDCGAffineTransformViewController: PDViewController {

    var imgv:UIImageView = {
        let imgv = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 240, height: 300))
        let imgURL = PDFileUtil.fileURL(fileName: "small", type: "png")
        let ciImg = CIImage.init(contentsOf: imgURL!)
        imgv.image = UIImage.init(ciImage: ciImg!)
        imgv.contentMode = .center
        imgv.borderLine(color: .red)
        return imgv
    }()
    
    var zoomSV:PDZoomScrollView = {
        let zoomv = PDZoomScrollView.init(frame: CGRect(x: 0, y: 0, width: 241, height: 241))
        return zoomv
    }()
    
    var curView:UIView?
    
    lazy var slider_a:PDValueSlider = quickSlider(0,"a",6)
    lazy var slider_b:PDValueSlider = quickSlider(1,"b",6)
    lazy var slider_c:PDValueSlider = quickSlider(2,"c",6)
    lazy var slider_d:PDValueSlider = quickSlider(3,"d",6)
    
    lazy var slider_x:PDValueSlider = quickSlider(4,"x",160)
    lazy var slider_y:PDValueSlider = quickSlider(5,"y",160)

    private let oriTransFor = ["a":1.0,"b":0.0,"c":0.0,"d":1.0,"x":0.0,"y":0.0];

    private func quickSlider(_ index:Int,_ mark:String,_ topV:Float)->PDValueSlider{
        let locationY = index * 40 + Int(navigationSizeHeight()) + 10
        let sliderW = UIScreen.main.bounds.width - 20;
        let slider = PDValueSlider.init(frame: CGRect.init(x: 10, y: locationY, width: Int(sliderW), height: 30),oriMark:mark)
        slider.vSliderBlock = {[weak self] (slider) -> Void in
            guard let this = self else { return }
            this.valueChangeSlider(slider)
        }
        slider.reloadLabelValue()
        slider.setRefrenceValueConfig(halfRefV: 1, topRefV: topV);
        slider.setRefrenceValue(ref_mapVal: Float(oriTransFor[mark]!))
        return slider
    }
    
    @objc private func valueChangeSlider(_ pSlider:PDValueSlider) {
        self.reloadImageViewTransform()
    }
    
    func reloadImageViewTransform()  {
        let transf = CGAffineTransform.init(a: self.slider_a.refValue,
                                            b: self.slider_b.refValue,
                                            c: self.slider_c.refValue,
                                            d: self.slider_d.refValue,
                                            tx: self.slider_x.refValue,
                                            ty: self.slider_y.refValue)
        self.curView?.transform = transf
    }
    
    func buildControlItems() {
        self.navigationController?.navigationBar.isHidden = true
        self.showNoneNavigationBackButton()
        self.showResetButton()
        self.showLogInfoButton()
        
        self.view.addSubview(self.slider_a)
        self.view.addSubview(self.slider_b)
        self.view.addSubview(self.slider_c)
        self.view.addSubview(self.slider_d)
        self.view.addSubview(self.slider_x)
        self.view.addSubview(self.slider_y)
    }
    

    override func resetButtonClick(_:UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.slider_a.setRefrenceValue(ref_mapVal: 1)
            self.slider_b.setRefrenceValue(ref_mapVal: 0)
            self.slider_c.setRefrenceValue(ref_mapVal: 0)
            self.slider_d.setRefrenceValue(ref_mapVal: 1)
            self.slider_x.setRefrenceValue(ref_mapVal: 0)
            self.slider_y.setRefrenceValue(ref_mapVal: 0)
            self.reloadImageViewTransform()
        }
        self.zoomSV.resetOriginalZoom()
    }
    
    override func logInfoButtonClick(_:UIButton) {
        print(self.curView?.layoutInfo() as Any)
        if self.curView == self.zoomSV {
            self.zoomSV.layoutZoomVInfo()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.zoomSV)
        self.curView = self.zoomSV;
        
//        self.view.addSubview(self.imgv)
//        self.curView = self.imgv

        self.buildControlItems()

        
        var curCP = self.view.center
        curCP.y += 100
        self.curView?.center = curCP
    }
}
