//
//  LYBCollectionviewlayout.swift
//  Swifttest
//
//  Created by xbsli on 2021/2/4.
//

import UIKit

class LYBCollectionviewlayout: UICollectionViewFlowLayout {
    //这里是重新设置cell的大小，这个暂时没有使用，一般在实例化collectionview的时候设置即可
    override var collectionViewContentSize: CGSize {
      let size: CGSize = super.collectionViewContentSize
      let collectionViewWidth: CGFloat = self.collectionView!.frame.size.width
      let nbOfScreen: Int = Int(ceil(size.width / collectionViewWidth))
      let newSize: CGSize = CGSize(width: collectionViewWidth * CGFloat(nbOfScreen), height: size.height)
      return newSize
    }
}
