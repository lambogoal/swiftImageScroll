//
//  ViewController.swift
//  Swifttest
//
//  Created by xbsli on 2021/1/29.
//

import UIKit
import Alamofire

class ViewController: UIViewController{
   
        override func viewDidLoad() {
            super.viewDidLoad()
            let v=LYBLunboWithTimertwo.init(frame: CGRect.init(x: 0, y: 100, width: WIDTH, height: 200))
            v.imageList=["lunboone","lunbotwo","lunbothree","lunbofour"]
            v.didselectBlock={
                index in
                print("当前第\(index)")
            }
            self.view.addSubview(v)
        }
   
    
}
