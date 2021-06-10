//
//  PDViewPiece.swift
//  PDemo
//
//  Created by xw.long on 2021/6/10.
//

import UIKit

enum PDPieceType {
    case blank
    case title
    case list
}

class PDViewPiece: UIView {
    
    var baseV:UIView = {
        let view = UIView.init(frame:CGRect(x: 0, y: 0, width: 300, height:600));
        view.backgroundColor = .gray
        view.borderLine(color: .orange)
        return view
    }()
    
    func pieceImageFromType(type:PDPieceType) -> UIImage {
        switch type {
        case .blank:break;
        case .title:
            let labelTitle = UILabel.init(frame: CGRect.init(x: 20, y: 20, width: 260, height: 50))
            labelTitle.font = UIFont.boldSystemFont(ofSize: 28)
            labelTitle.textColor = .green
            labelTitle.text = "这是一个标题";
            self.baseV.addSubview(labelTitle)
        case .list:
            let labelTitle = UILabel.init(frame: CGRect.init(x: 20, y: 20, width: 260, height: 50))
            labelTitle.font = UIFont.boldSystemFont(ofSize: 28)
            labelTitle.textColor = .green
            labelTitle.text = "这是一个标题";
            self.baseV.addSubview(labelTitle)
            for i in 0...2 {
                let labelList = UILabel.init(frame: CGRect.init(x: 20, y: 70 + i * (40), width: 260, height: 30))
                labelList.font = UIFont.boldSystemFont(ofSize: 24)
                labelList.textColor = .cyan
                labelList.borderLine(color: .yellow)
                labelList.text = "这是一个列表内容(\(i))";
                self.baseV.addSubview(labelList)
            }
        }
        
        let baseVImg = PDViewUtil.screenCaptureFrom(view: self.baseV, cutFrame: self.baseV.bounds)

        
        return baseVImg;
    }
}
