//
//  PDCollectionViewCell.swift
//  PDemo
//
//  Created by xw.long on 2021/3/26.
//

import UIKit

class PDCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.borderLine(color: .yellow)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
