//
//  PDCollectionViewProtocol.swift
//  PDemo
//
//  Created by xw.long on 2021/3/26.
//

import UIKit


@objc protocol PDCollectionViewDelegate {
    func PDCollection(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func PDCollection(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    
    
    //可选协议方法
    @objc optional
    func PDCollection(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    
    @objc optional
    func PDNumberOfSections(in collectionView: UICollectionView) -> Int
    
    
    @objc optional
    func PDcollection(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize


}
