//
//  PDStringCodeEncodeViewController.swift
//  PDemo
//
//  Created by xw.long on 2021/4/8.
//

import UIKit

class PDStringCodeEncodeViewController: PDTableViewController {
    var caseSections:Array<Array<String>>?
    
    var textCodeV:PDCodeTextView?

    override func viewDidLoad() {
        super.viewDidLoad()

        caseSections = [["UTF8","UTF16","UTF16"],["GB2312","GB18030"],["Base64-encode","md5"]];
        
        textCodeV = PDCodeTextView.init(frame: CGRect.init(x: 0, y: 0, width:UIScreen.main.bounds.width, height: 200))
        self.tableView.tableHeaderView = self.textCodeV!
    }
    

    override func PDTable(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let textStr = self.textCodeV?.codeTextV.text
        let destri = textStr?.PDGB2312WithUTF8String(enString: textStr!)
        print(destri)
    }

    override func PDNumberOfSections(in tableView: UITableView) -> Int {
        return caseSections?.count ?? 0
    }
    
    override func PDTable(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let caseSection:Array<Any> = caseSections?[section] ?? []
        return caseSection.count
    }
    
    override func PDTable(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PDTableViewCell = super.PDTable(tableView, cellForRowAt: indexPath) as! PDTableViewCell
        let section:Array<String> =  caseSections?[indexPath.section] ?? []
        let item = section[indexPath.row]
        cell.textLabel?.text = item
        return cell
    }

}
