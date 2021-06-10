//
//  PDCollectionViewCell.swift
//  PDemo
//
//  Created by xw.long on 2021/3/26.
//

import UIKit

class PDCollectionViewCell: UICollectionViewCell {
    
    
    private var tempIMGPath:String? = nil
    var backgroundImgPath:String?{
        get {
            return tempIMGPath
        }
        set {
            if newValue != nil {
                tempIMGPath = newValue
                self.loadBackgroundImageFromLocal(localImgPath:tempIMGPath)
            }
        }
    }
    
    private lazy var dispathQueue:DispatchQueue = DispatchQueue.init(label: "serial")
    
    lazy var backgroundImageView:UIImageView = {
        let imgv =  UIImageView.init(frame: self.bounds)
        imgv.contentMode = .scaleAspectFit
        self.contentView.addSubview(imgv)
        return imgv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.borderLine(color: .yellow)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func loadBackgroundImageFromLocal(localImgPath:String?) {
        if localImgPath != nil {
            self.dispathQueue.async {
                let image = PDFileUtil.image(imagePath:localImgPath!)
                let imgSize = 10//PDFileUtil.memorySizeWithImage(image: image)
                if imgSize < 90 {
                    if image != nil && localImgPath == self.backgroundImgPath {
                        DispatchQueue.main.async {
                            self.backgroundImageView.image = image
                        }
                    }
                } else {
                    print("图片太大了 \(String(describing: localImgPath)),size:\(imgSize)")
                }
            }
        }
    }
}
