//
//  PDFileUtil.swift
//  PDemo
//
//  Created by xw.long on 2021/3/18.
//

import Foundation
import UIKit

class PDFileUtil {
    static func fileURL(fileName:String?, type:String?) -> URL? {
        guard let fPath =  Bundle.main.path(forResource: fileName, ofType: type) else { return nil }
        let fUrl = URL.init(fileURLWithPath: fPath)
        return fUrl as URL
    }
    
    
    static func image(imagePath:String) -> UIImage? {
        let imgURL = URL.init(fileURLWithPath: imagePath)
        guard let ciImg = CIImage.init(contentsOf: imgURL)  else {
            return nil
        }
        let image = UIImage.init(ciImage: ciImg)
        return image
    }
    
    
    static func imagePathsFromResource() -> Array<String>? {
        var paths:Array<String>?
//        let bundlePath = Bundle.main.bundlePath
//        paths = FileManager.default.subpaths(atPath: bundlePath)
        let jpgs = Bundle.main.paths(forResourcesOfType: "jpg", inDirectory: nil)
        let pngs = Bundle.main.paths(forResourcesOfType: "png", inDirectory: nil)
        let jpegs = Bundle.main.paths(forResourcesOfType: "jpeg", inDirectory: nil)
        paths = jpgs + pngs + jpegs
        return paths
    }
}


