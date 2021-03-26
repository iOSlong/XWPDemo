//
//  PDCollectionViewController.swift
//  PDemo
//
//  Created by xw.long on 2021/3/26.
//

import UIKit
import SnapKit

class PDCollectionViewController: PDListViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.collectionDelegate != nil) {
            return self.collectionDelegate!.PDCollection(collectionView, numberOfItemsInSection: section)
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell:UICollectionViewCell?
        if (self.collectionDelegate != nil) {
            return (self.collectionDelegate?.PDCollection(collectionView, cellForItemAt: indexPath))!
        }
        if cell == nil {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier:NSStringFromClass(PDCollectionViewCell.self), for: indexPath) as! PDCollectionViewCell
        }
        return cell!
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (self.collectionDelegate!.PDNumberOfSections?(in: collectionView))!
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
         self.collectionDelegate?.PDCollection?(collectionView, didDeselectItemAt: indexPath)
    }
    
    
    var collectionView:UICollectionView!
    var collectionDelegate: PDCollectionViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: Public methods
    public func buildCollectionViewWithFlow(frameHandler: ((UICollectionView) ->Void)?,layoutHandler: (() -> UICollectionViewLayout)?){
        var flowLayout:UICollectionViewFlowLayout
        if layoutHandler != nil {
            flowLayout = layoutHandler!() as! UICollectionViewFlowLayout
        }else{
            flowLayout = UICollectionViewFlowLayout()
        }
        let collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.register(PDCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(PDCollectionViewCell.self))
        self.view.addSubview(collection)
        self.collectionView = collection
        if frameHandler != nil {
            frameHandler!(collection)
        }else{
            collection.snp.makeConstraints { (maker) in
                maker.top.equalTo(navigationSizeHeight())
                maker.left.right.equalTo(self.view)
                maker.bottom.equalTo(self.view.snp_bottomMargin)
            }
        }
    }
}
