//
//  PDInputViewsViewController.swift
//  PDemo
//
//  Created by xw.long on 2021/6/28.
//

import UIKit

class PDInputViewsViewController: PDTableViewController {

    var caseSections:Array<Array<Any>>?

    private func itemObject(indexPath:IndexPath) -> Dictionary<String,Any>{
        let caseSection:Array<Any> = caseSections![indexPath.section]
        let itemOBJ:Any = caseSection[indexPath.row]
        return itemOBJ as! Dictionary<String,Any>
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.showNoneNavigationBackButton()

        
        caseSections = [
            [
                ["UITextField":"PDTextFieldViewController"],
                ["UITextView":"PDUITextViewViewController"]
            ]
        ]
    }
    
    override func PDTable(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemOBJ =  self.itemObject(indexPath: indexPath) as Dictionary<String,Any>
        let className = itemOBJ.values.first as! String
        let objVC = PDVCUtil.viewControllerFromName(vcName: className)
        if (objVC != nil) {
            objVC?.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(objVC!, animated: true)
        }else{
            let key = itemOBJ.keys.first
            if key == "ImagePicker" {
            }
        }
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
