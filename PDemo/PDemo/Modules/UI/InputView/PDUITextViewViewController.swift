//
//  PDUITextViewViewController.swift
//  PDemo
//
//  Created by xw.long on 2021/6/28.
//

import UIKit

class PDUITextViewViewController: PDViewController {
    var textV:UITextView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        let span_h:CGFloat = 20.0
        let v_W = UIScreen.main.bounds.width - (span_h * 2);
        self.textV = UITextView.init(frame: CGRect.init(x:span_h, y: 100, width: v_W, height: 140))
        self.textV?.borderLine(color: .red)
        self.textV?.backgroundColor = .clear
        self.textV?.textColor = .yellow
        self.textV?.text = "这是一段测试路径名.png"
        self.view.addSubview(self.textV!)
        
        
        
        self.showNoneNavigationBackButton()
        self.showRightButton(title: "改名选择(不选取后缀名)")
        self.view.borderLine(color: .orange)
    }
    
    override func rightButtonClick(_: UIButton) {
        self.textV?.becomeFirstResponder()
        let suffix  = self.fileTypeSuffix(fileName: self.textV?.text)
        var suffixL = 0
        if suffix != nil {
            suffixL = suffix!.count+1
        }
        let lent    = (self.textV?.text?.count)!
        let endDoc  = (self.textV?.endOfDocument)!
        let start   = self.textV?.position(from: endDoc, offset: -lent)
        let end     = self.textV?.position(from: endDoc, offset: -suffixL)
        self.textV?.selectedTextRange = self.textV?.textRange(from: start!, to: end!)
    }
    
    func fileTypeSuffix(fileName:String?) -> String? {
        let components = fileName?.components(separatedBy: CharacterSet.init(charactersIn: "."))
        if components?.count ?? 1 >= 2 {
            return components?.last
        }
        return nil
    }

}
