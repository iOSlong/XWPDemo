//
//  PDScreenCaptureViewController.swift
//  PDemo
//
//  Created by xw.long on 2021/5/17.
//

import UIKit

class PDScreenCaptureViewController: PDTableViewController {
    var caseSections:Array<Array<Any>>?

    private func itemObject(indexPath:IndexPath) -> Dictionary<String,Any>{
        let caseSection:Array<Any> = caseSections![indexPath.section]
        let itemOBJ:Any = caseSection[indexPath.row]
        return itemOBJ as! Dictionary<String,Any>
    }

    var zoomSV:PDZoomScrollView = {
        let zoomv = PDZoomScrollView.init(frame:CGRect(x: 50, y: 100, width: 300, height: UIScreen.main.bounds.height - 120));
        zoomv.borderLine(color: .orange)
        return zoomv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        caseSections = [
            [
                ["CGAffine":"PDCGAffineTransformViewController"],
                ["ZoomScroll":"PDZoomScrollViewController"],
                ["ScreenCapture":"PDScreenCaptureViewController"]
            ]
        ]
        
        self.showNoneNavigationBackButton()
        self.showRightButton(title: "ScreenShot")
        self.view.borderLine(color: .orange)
        self.view.addSubview(self.zoomSV)
    }
    
    override func rightButtonClick(_: UIButton) {
        print("截屏显示看看")
        
        let captureImg = PDViewUtil.screenCaptureFrom(view: self.view, cutFrame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height));
        
        let captureImg2 = PDViewUtil.screenCaptureFrom(view: self.view, cutFrame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5));

        let imgConbine =  PDViewUtil.imageCombine(bottomImage: captureImg, topImage: captureImg2, topFrame: CGRect.init(x: 0, y: UIScreen.main.bounds.height * 0.5, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5))
        
        let footer = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
        footer.backgroundColor = .blue
        let footerImg = PDViewUtil.screenCaptureFrom(view: footer, cutFrame: footer.bounds)
        
        let header = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
        header.textColor = .green
        header.text = "这是一个标题内容"
        header.font = UIFont.systemFont(ofSize: 40)
        let headerImg = PDViewUtil.screenCaptureFrom(view: header, cutFrame: header.bounds)

        let imgCombines = PDViewUtil.imageCombine(imageArray: [headerImg,captureImg,captureImg2,imgConbine,footerImg], sizeContent: CGSize.init(width: UIScreen.main.bounds.width, height: 500));
        
        
        
        self.zoomSV.loadDemoImage(demoImage: imgCombines)
    }
    
    override func PDTable(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let caseSection:Array<Any> = caseSections?[section] ?? []
        return caseSection.count
    }
    
    override func PDTable(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PDTableViewCell = super.PDTable(tableView, cellForRowAt: indexPath) as! PDTableViewCell
        let itemOBJ =  self.itemObject(indexPath: indexPath) as Dictionary<String,Any>
        cell.textLabel?.text = itemOBJ.keys.first
        return cell
    }
}
