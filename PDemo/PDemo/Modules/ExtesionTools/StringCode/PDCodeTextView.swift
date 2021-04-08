//
//  PDCodeTextView.swift
//  PDemo
//
//  Created by xw.long on 2021/4/8.
//

import UIKit

class PDCodeTextView: UIView {

    var codeTextV:UITextView = {
        let textV =  UITextView.init()
        textV.borderLine(color: .orange)
        textV.layer.cornerRadius  = 5
        textV.keyboardType = .default
        textV.returnKeyType = .done
        return textV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.codeTextV)
        self.codeTextV.snp.makeConstraints { (maker) in
            maker.width.equalTo(self.snp.width).multipliedBy(0.9)
            maker.height.equalTo(self.snp.height).multipliedBy(0.9)
            maker.center.equalTo(self.snp.center)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
