//
//  PDPhotoListViewController.swift
//  PDemo
//
//  Created by xw.long on 2021/3/26.
//

import UIKit

class PDPhotoListViewController: PDCollectionViewController, PDCollectionViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionDelegate = self
        
        self.buildCollectionViewWithFlow { (collection) in
            
        } layoutHandler: { () -> UICollectionViewLayout? in
            return nil
        }
    }
    
    
    
    func PDCollection(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 5
    }
    func PDCollection(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:NSStringFromClass(PDCollectionViewCell.self), for: indexPath) as! PDCollectionViewCell
        return cell
    }
    
    func PDNumberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    //可选协议方法
    func PDCollection(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath){
        
    }
    
    
}
