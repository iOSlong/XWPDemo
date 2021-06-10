//
//  PDZoomScrollView.swift
//  PDemo
//
//  Created by xw.long on 2021/3/18.
//

import UIKit

struct PDImgDemo {
    let name:String
    let type:String
    init(_ name:String,_ type:String) {
        self.name = name
        self.type = type
    }
    var fullName:String {
        return self.name+"."+self.type
    }
}

class PDZoomScrollView: UIView,UIScrollViewDelegate{
    deinit {
        print("PDZoomScrollView 释放掉了")
        self.imgView.image = nil
    }
    
    var tapDoubleGR:UITapGestureRecognizer!
    var scrollView:UIScrollView!
    var imgTransF:PDIMGTransform!
    var imgView:PDImageView = {
        let imgv = PDImageView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        imgv.contentMode = .scaleAspectFit
        return imgv
    }()
    
    var labelZoom:UILabel = {
        let label = PDLabel(textColor: .orange, font: UIFont.italicSystemFont(ofSize: 8))
        return label
    }()
    
    var labelImgv:UILabel = {
        let label = PDLabel(textColor: .red, font: UIFont.italicSystemFont(ofSize: 8))
        return label
    }()
    
    //MARK:CustomStringConvertible,CustomDebugStringConvertible
    override var description: String{
        return "\(self.layoutInfo()),\(self.imgView.layoutInfo())"
    }
    override var debugDescription: String {
        return "\(self.layoutInfo()), imgView:\(self.imgView.layoutInfo())"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("layoutSubviews",self.imgView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.scrollView = UIScrollView.init(frame: self.bounds)
        if #available(iOS 11.0, *) {//解决scrollView上分状态栏冗余空白区域问题。
            self.scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        self.scrollView.contentSize = self.bounds.size
        self.scrollView.delegate = self
        self.addSubview(self.scrollView!)
        self.scrollView.snp.makeConstraints({ (maker) in
            maker.edges.equalTo(self)
        })
        
        self.imgView.frame = self.scrollView!.bounds
        self.scrollView.addSubview(self.imgView)
        
        
        self.addSubview(self.labelZoom)
        self.imgView.addSubview(self.labelImgv)
        self.labelZoom.snp.makeConstraints { (maker) in
            maker.right.equalTo(self.snp.right)
            maker.bottom.equalTo(self.snp.top);
        }
        self.labelImgv.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.imgView.snp.top)
            maker.left.equalTo(self.imgView.snp.left)
        }
        
        self.borderLine(color: .orange)
        self.imgView.borderLine(color: .red)

        self.loadGetures()
        self.addFrameObserver()
        
        
        let imgDemos = [PDImgDemo("small","png"),
        PDImgDemo("sageAlliance","jpg"),
        PDImgDemo("screenCut","jpeg"),
        PDImgDemo("long_heightSmall","jpg"),
        PDImgDemo("long_widthSmall","jpg"),
        PDImgDemo("long_widthBig","png"),
        PDImgDemo("long_widthSmall","jpg")]

        let imgDemo = imgDemos[3]
        let imgURL = PDFileUtil.fileURL(fileName: imgDemo.name, type: imgDemo.type)
        let ciImg = CIImage.init(contentsOf: imgURL!)
        let demoImage = UIImage.init(ciImage: ciImg!)
        self.loadDemoImage(demoImage: demoImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutZoomVInfo() {
        if self.imgTransF == nil {
            return
        }
        let imgvInfo = self.imgView.layoutInfo()
        print("imgView:",imgvInfo)
        print("scrolll:",self.scrollView as Any)
        
        self.labelZoom.text = String.init(format: "[%.1f, %1.f]", (self.frame.width),(self.frame.height))
        self.labelImgv.text = String.init(format: "[%1.f, %1.f]\n图:%1.fx%1.f)", (self.imgView.frame.width),(self.imgView.frame.height),(self.imgTransF.sizeImageScale.width),(self.imgTransF.sizeImageScale.height))
    }
    
    func loadDemoImage(demoImage:UIImage)  {
        self.imgView.image = demoImage
//        self.imgView.loadLargeImage(image: demoImage)
        
        self.imgTransF = PDIMGTransform.init(imgSize: demoImage.size, containerSize: self.frame.size, contentMode: self.imgView.contentMode)
        self.scrollView.maximumZoomScale = self.imgTransF.maxScale + 1
        self.scrollView.minimumZoomScale = min(self.imgTransF.minScale, 0.5)
        self.resetOriginalZoom()
        
        self.layoutZoomVInfo()
    }
    
    
    public func resetOriginalZoom() {
        self.scrollView.setZoomScale(1, animated: true)
        self.scrollView.transform = CGAffineTransform.identity
        self.imgView.transform = CGAffineTransform.identity
        self.imgView.frame = CGRect.init(origin: CGPoint.zero, size: self.imgTransF.sizeAspectFit)
        let sizeMode:CGSize = self.imgTransF.sizeAspectFill;
        self.imgView.transform = CGAffineTransform.init(a: self.imgTransF.scaleFill, b: 0, c: 0, d: self.imgTransF.scaleFill, tx: 0, ty: 0);
        self.scrollView.contentSize = CGSize.init(width: max(sizeMode.width, self.frame.width), height: max(sizeMode.height, self.frame.height))
        self.imgView.center = CGPoint.init(x: 0.5 * max(sizeMode.width, self.frame.width), y: 0.5 * max(sizeMode.height, self.frame.height))
        self.scrollView.contentOffset = CGPoint.zero
    }
    
    private func loadGetures(){
        tapDoubleGR = UITapGestureRecognizer.init(target: self, action: #selector(doubleTapAction(_:)))
        tapDoubleGR?.numberOfTapsRequired = 2
        self.addGestureRecognizer(tapDoubleGR!)
    }
    
    @objc private func doubleTapAction(_ tap:UITapGestureRecognizer){
        let oldTransF = self.imgView.transform
        var transF = self.imgView.transform
        var touchP = tap.location(in: self.imgView)
        touchP = CGPoint.init(x: touchP.x * oldTransF.a, y: touchP.y * oldTransF.d)
        
        if self.imgTransF.longTyp == .Horizontal {
            if transF.a < self.imgTransF.scaleFill {
                transF.a = self.imgTransF.scaleFill
                transF.d = self.imgTransF.scaleFill
            }else{
                transF.a = self.imgTransF.scaleFit
                transF.d = self.imgTransF.scaleFit
            }
        }else{
            if transF.a < self.imgTransF.maxScale {
                transF.a = self.imgTransF.maxScale
                transF.d = self.imgTransF.maxScale
            } else {
                transF.a = self.imgTransF.scaleFill
                transF.d = self.imgTransF.scaleFill
            }
        }
        let ratioCalce = transF.a/oldTransF.a
        let oriOffset = self.scrollView.contentOffset
        let destP  = CGPoint.init(x: touchP.x * ratioCalce, y: touchP.y * ratioCalce)
        let offsetP = CGPoint.init(x: destP.x - touchP.x, y: destP.y - touchP.y)
        var offsetScroll = CGPoint.init(x: oriOffset.x + offsetP.x, y: oriOffset.y + offsetP.y)
        
        let modeSize:CGSize = self.imgTransF.sizeAspectFit;

        let conSize = CGSize.init(width: transF.a * modeSize.width, height: transF.d * modeSize.height)
        offsetScroll = CGPoint.init(x: max(offsetScroll.x, 0), y: max(offsetScroll.y, 0))
        offsetScroll = CGPoint.init(x: min(offsetScroll.x, max(conSize.width-self.scrollView!.frame.width,0)), y: min(offsetScroll.y, max(conSize.height-self.scrollView!.frame.height,0)))
        
        UIView.animate(withDuration: 0.25) {
            self.imgView.transform = transF
            self.scrollView!.contentSize = CGSize.init(width: max(conSize.width, self.frame.width), height: max(conSize.height, self.frame.height))
            self.imgView.center = CGPoint.init(x: 0.5 * max(conSize.width, self.frame.width), y: 0.5 * max(conSize.height, self.frame.height))
            self.scrollView!.contentOffset = offsetScroll
        }
    }
    
    private func addFrameObserver(){
        self.addObserver(self, forKeyPath: "transform", options: .new, context: nil)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        // 方式1.匹配keypath
        if keyPath == "transform" {
            self.layoutZoomVInfo()
            print(context as Any)
        }
    }
    override class func addObserver(_ observer: NSObject, forKeyPath keyPath: String, options: NSKeyValueObservingOptions = [], context: UnsafeMutableRawPointer?) {
        // 方式1.匹配keypath
        if keyPath == "frame" {
            print(context as Any)
        }
    }


    
    //MARK:UIScrollViewDelegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        self.layoutZoomVInfo()
        return self.imgView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        UIView.animate(withDuration: 0.25) {
            self.imgView.center = CGPoint.init(x: max(scrollView.contentSize.width, scrollView.frame.width) * 0.5, y: max(scrollView.contentSize.height, scrollView.frame.height) * 0.5)
        }
    }
}
