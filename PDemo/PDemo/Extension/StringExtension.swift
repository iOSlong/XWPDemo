//
//  StringExtension.swift
//  PDemo
//
//  Created by xw.long on 2021/4/8.
//

import Foundation

extension String {
    func PDData(encoding:Encoding) -> Data? {
        return self.data(using: encoding)
    }
    
    func PDStringFromData(data:Data,encoding:Encoding) -> String? {
        return String.init(data: data, encoding: encoding)
    }
    
    func PDGB2312WithUTF8String(enString:String) -> String?  {
        let data:Data = enString.PDData(encoding: .utf8)!
        let cfEnc = CFStringEncodings.GB_2312_80
        let enc = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(cfEnc.rawValue))
        let str = String(data: data, encoding: String.Encoding(rawValue: enc))
        return str
    }
}
