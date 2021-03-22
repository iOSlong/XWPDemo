//
//  PDFileUtil.swift
//  PDemo
//
//  Created by xw.long on 2021/3/18.
//

import Foundation

class PDFileUtil {
    static func fileURL(fileName:String?, type:String?) -> URL? {
        guard let fPath =  Bundle.main.path(forResource: fileName, ofType: type) else { return nil }
        let fUrl = URL.init(fileURLWithPath: fPath)
        return fUrl as URL
    }
}


