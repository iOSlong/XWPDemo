//
//  PDImageView.swift
//  PDemo
//
//  Created by xw.long on 2021/5/18.
//

import UIKit

class PDImageView: UIImageView {
    var tiledCount = 81
    var originImage:UIImage?
    var imageRect:CGRect?
    var imageScale_w:CGFloat?
    var imageScale_h:CGFloat?
    
    func loadLargeImage(image:UIImage){
        if image.cgImage == nil {
            return
        }
        if tiledCount == 0 {
            tiledCount = 81
        }
        originImage = image
        imageRect = CGRect.init(x: 0, y: 0, width: (originImage?.cgImage!.width)!, height: (originImage?.cgImage!.height)!)
        imageScale_w = self.bounds.width / imageRect!.width
        imageScale_h = self.bounds.height / imageRect!.height
        
        let tiledLayer:CATiledLayer = self.layer as! CATiledLayer;

        let scale = max(1/imageScale_w!, 1/imageScale_h!)
        let lev = ceil(scale)
        tiledLayer.levelsOfDetail = 1;
        tiledLayer.levelsOfDetailBias = Int(lev);
        
        if(tiledCount > 0){
            let tileSizeScale = sqrt(Double(tiledCount))/2;
            var tileSize = self.bounds.size;
            tileSize.width = (tileSize.width / CGFloat(tileSizeScale));
            tileSize.height = (tileSize.height / CGFloat(tileSizeScale));
            tiledLayer.tileSize = tileSize;
        }
    }
    
    override class var layerClass: AnyClass {
        return CATiledLayer.self
    }
    
    override func draw(_ rect: CGRect) {
        autoreleasepool {
            let imageCutRect = CGRect.init(x: rect.origin.x / imageScale_w!,
                                           y: rect.origin.y / imageScale_h!,
                                           width: rect.size.width / imageScale_w!,
                                           height: rect.size.height / imageScale_h!);
            
            let imageRef:CGImage = (originImage?.cgImage!)!.cropping(to: imageCutRect)!;
            let tileImage:UIImage = UIImage.init(cgImage: imageRef)
            let context:CGContext = UIGraphicsGetCurrentContext()!;
            UIGraphicsPushContext(context);
            tileImage.draw(in: rect)
            UIGraphicsPopContext();
        }
    }
}
