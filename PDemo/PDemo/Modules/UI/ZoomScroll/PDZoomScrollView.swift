//
//  PDZoomScrollView.swift
//  PDemo
//
//  Created by xw.long on 2021/3/18.
//

import UIKit

class PDZoomScrollView: UIView,UIScrollViewDelegate{
    var scrollView:UIScrollView?
    
    var imgView:UIImageView = {
        let imgv = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        let imgURL = PDFileUtil.fileURL(fileName: "long_height", type: "jpg")
        let ciImg = CIImage.init(contentsOf: imgURL!)
        imgv.image = UIImage.init(ciImage: ciImg!)
        imgv.contentMode = .scaleAspectFit
        imgv.borderLine(color: .red)
        return imgv
    }()
    
    //MARK:CustomStringConvertible,CustomDebugStringConvertible
    override var description: String{
        return "frame:\(self.frame),imgView:\(self.imgView.description)"
    }
    override var debugDescription: String {
        return "Debug_frame:\(self.frame),imgView:\(self.imgView.description)"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.borderLine(color: .orange)

        self.scrollView = UIScrollView.init(frame: self.bounds)
        self.scrollView?.contentSize = self.bounds.size
        self.scrollView?.maximumZoomScale = 2
        self.scrollView?.minimumZoomScale = 0.5
        self.scrollView?.delegate = self
        self.scrollView?.addSubview(self.imgView)
        self.addSubview(self.scrollView!)
        self.scrollView?.snp.makeConstraints({ (maker) in
            maker.edges.equalTo(self)
        })

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:UIScrollViewDelegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imgView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
    }
}
