//
//  LYBLunboCollectionViewCell.swift
//  DriveHome
//
//  Created by lambo on 2021/1/31.
//

import UIKit

class LYBLunboCollectionViewCell: UICollectionViewCell {
    var imageV:UIImageView!
    var imagestr:String="center"{
        willSet(newvalue){
//            print("new\(newvalue)")
            imageV.image=UIImage.init(named: newvalue)
        }
        didSet(oldvalue){
//            print("old\(oldvalue)")
//       print("imagestr\(imagestr)")
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createCell(){
        self.backgroundColor=UIColor.red
        imageV = UIImageView.init(frame:CGRect.init(x: 0, y: 0, width: WIDTH, height: self.frame.size.height))
        imageV.image=UIImage.init(named: "center")
        imageV.isUserInteractionEnabled=true
        self.addSubview(imageV)
            }
    

}
