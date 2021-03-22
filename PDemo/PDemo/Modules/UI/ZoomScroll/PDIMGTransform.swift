//
//  PDIMGTransform.swift
//  PDemo
//
//  Created by xw.long on 2021/3/22.
//

import Foundation
import UIKit

struct PDIMGTransform {
    var sizeAspectFit:CGSize
    var sizeAspectFill:CGSize
    var scaleFit:CGFloat
    var scaleFill:CGFloat
    
    let sizeImage:CGSize
    let containerSize:CGSize
    let contentMode:UIView.ContentMode
    init(imgSize:CGSize, containerSize:CGSize,contentMode:UIView.ContentMode) {
        self.sizeImage = imgSize
        self.containerSize = containerSize
        self.contentMode = contentMode
        
        let imgW = imgSize.width / UIScreen.main.scale
        let imgH = imgSize.height / UIScreen.main.scale
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
        switch contentMode {
        case .scaleAspectFill:fallthrough
        case .scaleToFill:
            self.scaleFit = self.sizeAspectFit.width / self.sizeAspectFill.width
            self.scaleFill = 1
        case .center:
            self.scaleFit = self.sizeAspectFit.width / min(imgW, conW)
            self.scaleFill = self.sizeAspectFill.width / min(imgW, conH)
        default:
            self.scaleFit = 1
            self.scaleFill = self.sizeAspectFill.width / self.sizeAspectFit.width
        }
    }
    
    func sizeForContentMode(_ contentMode:UIView.ContentMode) -> CGSize {
        switch contentMode {
        case .scaleAspectFill:fallthrough
        case .scaleToFill:
            return self.sizeAspectFill
        default:
            return self.sizeAspectFit
        }
    }
}
