//
//  PDTableViewController.swift
//  XWPDemo
//
//  Created by xw.long on 2021/3/17.
//

import UIKit
import SnapKit

class PDTableViewController: PDListViewController,UITableViewDelegate,UITableViewDataSource {
//    MARK:UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.PDTable(tableView, numberOfRowsInSection: section)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        let num:Int =  self.PDNumberOfSections(in: tableView)
        return num > 0 ? num:1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.PDTable(tableView, cellForRowAt: indexPath)
    }
//    MARK:UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.PDTable(tableView, didSelectRowAt: indexPath)
    }
    
    //list控件变量
    lazy var tableView:UITableView = {
        let list =  UITableView.init(frame: self.view.bounds, style: .plain)
        list.register(PDTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(PDTableViewCell.self))
        list.backgroundColor = .clear
        list.delegate = self
        list.dataSource = self
        return list
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureTableView()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Public methods
    public func configureTableView(){
        self.buildTableViewWithFrameLayout { (table) in
            table.snp.makeConstraints { (maker) in
                maker.top.equalTo(navigationSizeHeight())
                maker.left.right.equalTo(self.view)
                maker.bottom.equalTo(self.view.snp_bottomMargin)
            }
        }
    }
    
    public func buildTableViewWithFrameLayout(layoutHandler:(UITableView) -> Void){
        self.view.addSubview(self.tableView)
        layoutHandler(self.tableView)
    }
    
    public func PDTable(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell:PDTableViewCell = tableView.dequeueReusableCell(withIdentifier:NSStringFromClass(PDTableViewCell.self)) as! PDTableViewCell
        return cell
    }
    public func PDNumberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    public func PDTable(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    public func PDTable(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
