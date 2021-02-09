//
//  LYBLunbowithtimerCollectionviewcell.swift
//  Swifttest
//
//  Created by xbsli on 2021/2/8.
//

import UIKit

class LYBLunbowithtimerCollectionviewcell: UICollectionViewCell {
    var imageV:UIImageView!
    var imagestr:String="center"{
        willSet(newvalue){

            //图片url
            if  newvalue.range(of: "http://") != nil || newvalue.range(of: "https://") != nil{
                //这里用的Data的方式显示图片，也可以使用图片下载框架Kingfisher
                let imageData:Data=try! Data.init(contentsOf: URL.init(string: newvalue)!)
                imageV.image=UIImage.init(data: imageData)
            }else{
                //图片名
                 imageV.image=UIImage.init(named: newvalue)
            }
           
        }
        didSet(oldvalue){

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
