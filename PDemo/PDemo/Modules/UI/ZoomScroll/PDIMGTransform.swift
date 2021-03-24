//
//  PDIMGTransform.swift
//  PDemo
//
//  Created by xw.long on 2021/3/22.
//

import Foundation
import UIKit

enum IMGLongType {
    case UnKnown  //default ,默认未知(不是长图)
    case Horizontal //横向长图
    case Vertical   //纵向长图
}

struct PDIMGTransform {
    let sizeAspectFit:CGSize
    let sizeAspectFill:CGSize
    let scaleFit:CGFloat
    let scaleFill:CGFloat
    let maxScale:CGFloat
    let minScale:CGFloat
    
    let sizeImage:CGSize
    let sizeImageScale:CGSize
    let containerSize:CGSize
    let contentMode:UIView.ContentMode
    
    let longTyp:IMGLongType
    
    init(imgSize:CGSize, containerSize:CGSize,contentMode:UIView.ContentMode) {
        self.sizeImage = imgSize
        self.containerSize = containerSize
        self.contentMode = contentMode
        let imgW = imgSize.width / UIScreen.main.nativeScale
        let imgH = imgSize.height / UIScreen.main.nativeScale
        self.sizeImageScale = CGSize(width: imgW,height: imgH)
        
        let conW = containerSize.width
        let conH = containerSize.height
        
        let ratioImg = imgW / imgH
        let ratioCon = conW / conH
        
        if ratioImg > ratioCon { /*case:横向长图*/
            //fill
            let fillH = conH
            let fillW = conH * ratioImg
            self.sizeAspectFill = CGSize.init(width: fillW, height: fillH)
            
            //fit
            let fitW = conW
            let fitH = conW / ratioImg
            self.sizeAspectFit = CGSize.init(width: fitW, height: fitH)
        } else { /*case:纵向长图*/
            //fill
            let fillW = conW
            let fillH = fillW / ratioImg
            self.sizeAspectFill = CGSize.init(width: fillW, height: fillH)
            
            //fit
            let fitH = conH
            let fitW = fitH * ratioImg
            self.sizeAspectFit = CGSize.init(width: fitW, height: fitH)
        }
        /*
            （.scaleToFill）默认是UIImageView的默认contentMode
            是下面👇情况中的第一种。
         */
//        switch contentMode {
//        case .scaleAspectFill:fallthrough
//        case .scaleToFill:
//            self.scaleFit = self.sizeAspectFit.width / self.sizeAspectFill.width
//            self.scaleFill = 1
//        case .center:
//            self.scaleFit = self.sizeAspectFit.width / min(imgW, conW)
//            self.scaleFill = self.sizeAspectFill.width / min(imgW, conH)
//        default:
//            self.scaleFit = 1
//            self.scaleFill = self.sizeAspectFill.width / self.sizeAspectFit.width
//        }
        
        self.scaleFit  = 1
        self.scaleFill = self.sizeAspectFill.width / self.sizeAspectFit.width

        /*最小缩放系数：使展示出的图不大于scaleFit，且不大于分辨率对应屏幕尺寸比*/
        self.minScale = min(self.scaleFit, imgW/conW)
        /*最大缩放系数：使展示出的图不小于scaleFill，且不能小于原图分辨率屏幕尺寸比*/
        self.maxScale = max(self.scaleFill, imgW/conW)
        
        
        let sideRatio:Double = Double(imgW/imgH)
        let longRatio = 2.0
        /*高宽比(w/h)在longRatio及其倒数之外的可认定为长图。*/
        if sideRatio <= 1.0/longRatio {
            self.longTyp = .Vertical
        }else if sideRatio >= longRatio {
            self.longTyp = .Horizontal
        }else{
            self.longTyp = .UnKnown
        }
        
        print("imgTransInfo:",self)
    }
    
    func sizeForContentMode(_ contentMode:UIView.ContentMode) -> CGSize {
        switch contentMode {
        case .scaleAspectFill:fallthrough
        case .scaleToFill:
            if self.longTyp == .Vertical {
                return self.sizeAspectFill
            }else{
                return self.sizeAspectFit
            }
        default:
            return self.sizeAspectFit
        }
    }
}
