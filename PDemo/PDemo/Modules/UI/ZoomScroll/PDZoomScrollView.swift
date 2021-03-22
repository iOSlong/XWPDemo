//
//  PDZoomScrollView.swift
//  PDemo
//
//  Created by xw.long on 2021/3/18.
//

import UIKit

class PDZoomScrollView: UIView,UIScrollViewDelegate{
    var tapDoubleGR:UITapGestureRecognizer?
    var scrollView:UIScrollView?
    var imgTransF:PDIMGTransform?
    var imgView:UIImageView = {
        let imgv = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
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
        self.scrollView?.contentSize = self.bounds.size
        self.scrollView?.maximumZoomScale = 2
        self.scrollView?.minimumZoomScale = 0.5
        self.scrollView?.delegate = self
        self.addSubview(self.scrollView!)
        self.scrollView?.snp.makeConstraints({ (maker) in
            maker.edges.equalTo(self)
        })
        
        self.imgView.frame = self.scrollView!.bounds
        self.scrollView?.addSubview(self.imgView)
        
        
        self.addSubview(self.labelZoom)
        self.imgView.addSubview(self.labelImgv)
        self.labelZoom.snp.makeConstraints { (maker) in
            maker.right.equalTo(self.snp.right)
            maker.bottom.equalTo(self.snp.top);
        }
        self.labelImgv.snp.makeConstraints { (maker) in
            maker.center.equalTo(self.imgView.snp.center)
        }
        
        self.borderLine(color: .orange)
        self.imgView.borderLine(color: .red)

        self.loadGetures()
        self.addFrameObserver()
        
        self.layoutZoomVInfo()
        
        self.loadDemoImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadDemoImage()  {
        let imgURL = PDFileUtil.fileURL(fileName: "long_height", type: "jpg")
        let ciImg = CIImage.init(contentsOf: imgURL!)
        let demoImage = UIImage.init(ciImage: ciImg!)
        self.imgView.image = demoImage
        self.imgTransF = PDIMGTransform.init(imgSize: demoImage.size, containerSize: self.frame.size, contentMode: self.imgView.contentMode)
        
        self.resetOriginalZoom()
    }
    
    func layoutZoomVInfo() {
        let imgvInfo = self.imgView.layoutInfo()
        print("imgView:",imgvInfo)
        print("scrolll:",self.scrollView as Any)
        
        self.labelZoom.text = String.init(format: "[%.1f, %1.f]", (self.frame.width),(self.frame.height))
        self.labelImgv.text = String.init(format: "[%.1f, %1.f]", (self.imgView.frame.width),(self.imgView.frame.height))
    }
    
    public func resetOriginalZoom() {
        self.scrollView?.setZoomScale(1, animated: true)
        self.scrollView?.transform = CGAffineTransform.identity
        self.imgView.transform = CGAffineTransform.identity
        
        let sizeMode:CGSize = self.imgTransF!.sizeForContentMode(self.imgView.contentMode)
        self.imgView.frame = CGRect.init(origin: CGPoint.zero, size: sizeMode)
        self.scrollView?.contentSize = CGSize.init(width: max(sizeMode.width, self.frame.width), height: max(sizeMode.height, self.frame.height))
        self.scrollView?.contentOffset = CGPoint.zero
    }
    
    private func loadGetures(){
        tapDoubleGR = UITapGestureRecognizer.init(target: self, action: #selector(doubleTapAction(_:)))
        tapDoubleGR?.numberOfTapsRequired = 2
        self.addGestureRecognizer(tapDoubleGR!)
    }
    
    @objc private func doubleTapAction(_ tap:UITapGestureRecognizer){
        let  touchP = tap.location(in: self)
        print("touchP:",touchP)
        print("offset:",self.scrollView!.contentOffset)
        print(self.imgView)
        
        var transF = self.scrollView!.transform
        if transF.a <= 1.8 {
            transF.a = 1.8
            transF.d = 1.8
        } else {
            transF.a = 1
            transF.d = 1
        }
        let oriOffset = self.scrollView!.contentOffset
        let destP  = CGPoint.init(x: touchP.x * transF.a, y: touchP.y * transF.d)
        var offset = CGPoint.init(x: destP.x - touchP.x, y: destP.y - touchP.y)
        offset = CGPoint.init(x: offset.x + oriOffset.x, y: offset.y + oriOffset.y)
        
        let conSize = CGSize.init(width: transF.a * self.imgView.frame.width, height: transF.a * self.imgView.frame.height)
        
        UIView.animate(withDuration: 0.25) {
            self.imgView.transform = transF
            self.scrollView?.contentSize = CGSize.init(width: max(conSize.width, self.frame.width), height: max(conSize.height, self.frame.height))
            self.imgView.center = CGPoint.init(x: 0.5 * max(conSize.width, self.frame.width), y: 0.5 * max(conSize.height, self.frame.height))
            self.scrollView?.contentOffset = offset
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
