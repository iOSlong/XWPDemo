//
//  PDTextFieldViewController.swift
//  PDemo
//
//  Created by xw.long on 2021/6/28.
//

import UIKit

class PDTextFieldViewController: PDViewController {
    
    var field:UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        let span_h:CGFloat = 30.0
        let v_W = UIScreen.main.bounds.width - (span_h * 2);
        self.field = UITextField.init(frame: CGRect.init(x: span_h, y: 100, width: v_W, height: 40))
        self.field?.borderLine(color: .red)
        self.field?.textColor = .yellow
        self.field?.text = "这是一段测试路径名.png"
        self.view.addSubview(self.field!)
        
        
        self.showNoneNavigationBackButton()
        self.showRightButton(title: "改名选择(不选取后缀名)")
        self.view.borderLine(color: .orange)
    }
    
    override func rightButtonClick(_: UIButton) {
        self.field?.becomeFirstResponder()
        let suffix  = self.fileTypeSuffix(fileName: self.field?.text)
        var suffixL = 0
        if suffix != nil {
            suffixL = suffix!.count+1
        }
        let lent    = (self.field?.text?.count)!
        let endDoc  = (self.field?.endOfDocument)!
        let start   = self.field?.position(from: endDoc, offset: -lent)
        let end     = self.field?.position(from: endDoc, offset: -suffixL)
        self.field?.selectedTextRange = self.field?.textRange(from: start!, to: end!)
    }
    
    func fileTypeSuffix(fileName:String?) -> String? {
        let components = fileName?.components(separatedBy: CharacterSet.init(charactersIn: "."))
        if components?.count ?? 1 >= 2 {
            return components?.last
        }
        return nil
    }
}
