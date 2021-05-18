//
//  PDViewUtil.swift
//  PDemo
//
//  Created by xw.long on 2021/5/17.
//

import UIKit

class PDViewUtil: NSObject {
    //MARK:截取屏幕图片相关
    static func screenCaptureFrom(view:UIView, cutFrame:CGRect) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(cutFrame.size, true, 0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    static func imageCombine(bottomImage:UIImage, topImage:UIImage, topFrame:CGRect) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bottomImage.size, true, 0)
        bottomImage.draw(in: CGRect.init(origin: CGPoint.zero, size: bottomImage.size))
        topImage.draw(in: topFrame);
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        /*
         将图片保存到手机系统相册中。
         UIImageWriteToSavedPhotosAlbum(img!, nil, nil, nil)
         */
        return img!
    }
    
    static func imageCombine(imageArray:Array<UIImage>,sizeContent:CGSize) -> UIImage {
        let sizeW:CGFloat = sizeContent.width
        var sizeH:CGFloat = 0.0
        let screenScale:CGFloat = 1.0 //UIScreen.main.scale
        for img:UIImage in imageArray {
            sizeH += img.size.height/screenScale
        }
        let sizeC = CGSize.init(width: sizeW, height: sizeH)
        UIGraphicsBeginImageContextWithOptions(sizeC, true, 0)
        var locationY:CGFloat = 0.0
        for img:UIImage in imageArray {
            let imgW = img.size.width/screenScale
            let imgH = img.size.height/screenScale
            img.draw(in: CGRect.init(x: 0, y: locationY, width: imgW, height: imgH))
            locationY += img.size.height/screenScale
        }
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    static func imageScaleToSize(image:UIImage, newSize:CGSize) -> NSData {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect.init(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImg = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImg.pngData()! as NSData
    }
}

