//
//  PDCollectionViewController.swift
//  PDemo
//
//  Created by xw.long on 2021/3/26.
//

import UIKit
import SnapKit

class PDCollectionViewController: PDListViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.collectionDelegate != nil) {
            return self.collectionDelegate!.PDCollection(collectionView, numberOfItemsInSection: section)
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell:UICollectionViewCell?
        if (self.collectionDelegate != nil) {
            return (self.collectionDelegate!.PDCollection(collectionView, cellForItemAt: indexPath))
        }
        if cell == nil {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier:NSStringFromClass(PDCollectionViewCell.self), for: indexPath) as! PDCollectionViewCell
        }
        return cell!
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if (self.collectionDelegate != nil) {
            return 1
        }
        return self.collectionDelegate!.PDNumberOfSections?(in: collectionView) ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.collectionDelegate?.PDCollection?(collectionView, didSelectItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        self.collectionDelegate?.PDcollection?(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath) ?? CGSize.init(width: 64, height: 64)
    }

    
    
    
    
    
    var collectionView:UICollectionView!
    var collectionDelegate: PDCollectionViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

       

        // Do any additional setup after loading the view.
    }
    
    //MARK: Public methods
    public func buildCollectionViewWithFlow(frameHandler: ((UICollectionView) ->Void)?,layoutHandler: (() -> UICollectionViewLayout?)?){
        var flowLayout:UICollectionViewFlowLayout?
        if layoutHandler != nil {
            flowLayout = layoutHandler!() as? UICollectionViewFlowLayout ?? nil
        }
        if flowLayout == nil {
            flowLayout = UICollectionViewFlowLayout()
        }
        let collection = UICollectionView.init(frame:self.view.bounds, collectionViewLayout: flowLayout!)
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
