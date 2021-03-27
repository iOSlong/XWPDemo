//
//  PDPhotoListViewController.swift
//  PDemo
//
//  Created by xw.long on 2021/3/26.
//

import UIKit

typealias PDPhotoListSelected = (_ imagePath:String) -> Void


class PDPhotoListViewController: PDCollectionViewController, PDCollectionViewDelegate {
    
    var photoDismissWithSelectedImage:PDPhotoListSelected?

    var imagePaths:Array<String>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionDelegate = self
        
        self.buildCollectionViewWithFlow(frameHandler: nil, layoutHandler: nil)
        
        let paths =  PDFileUtil.imagePathsFromResource()
        self.imagePaths = paths
        self.collectionView.reloadData()
    }
    
    
    
    func PDCollection(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.imagePaths?.count ?? 0
    }
    func PDCollection(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell:PDCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:NSStringFromClass(PDCollectionViewCell.self), for: indexPath) as! PDCollectionViewCell
        if self.imagePaths != nil {
            let imgPath = self.imagePaths![indexPath.row]
            cell.backgroundImgPath = imgPath
        }
        return cell
    }
    
    func PDNumberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    //可选协议方法
    func PDcollection(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 200,height: 200)
    }
    
    func PDCollection(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        if self.imagePaths != nil {
            let imgPath = self.imagePaths![indexPath.row]
            if (self.photoDismissWithSelectedImage != nil && imgPath != nil) {
                self.photoDismissWithSelectedImage!(imgPath)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

}
