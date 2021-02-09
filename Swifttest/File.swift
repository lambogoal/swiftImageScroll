//
//  File.swift
//  Swifttest
//
//  Created by xbsli on 2021/2/4.
//

import Foundation
import  UIKit

let WIDTH = UIScreen.main.bounds.size.width

let HEIGHT = UIScreen.main.bounds.size.height

// 判断 iPad

let Device_Is_iPad = (UIDevice().userInterfaceIdiom == UIUserInterfaceIdiom.pad)

// 判断iPhone X

let Device_Is_iPhoneX=__CGSizeEqualToSize(CGSize.init(width: 1125/3, height: 2436/3), UIScreen.main.bounds.size)

//判断iPHoneXr | 11

let Device_Is_iPhoneXr=__CGSizeEqualToSize(CGSize.init(width: 828/2, height: 1792/2), UIScreen.main.bounds.size)

//判断iPHoneXs | 11Pro

let Device_Is_iPhoneXs=__CGSizeEqualToSize(CGSize.init(width: 1125/3, height: 2436/3), UIScreen.main.bounds.size)

//判断iPhoneXs Max | 11ProMax

let Device_Is_iPhoneXs_Max=__CGSizeEqualToSize(CGSize.init(width: 1242/3, height: 2688/3), UIScreen.main.bounds.size)

 

let Device_Is_iphoneX_All = (Device_Is_iPhoneX || Device_Is_iPhoneXr || Device_Is_iPhoneXs||Device_Is_iPhoneXs_Max)

 

//判断iPhone12_Mini

let Device_Is_iPhone12_Mini=__CGSizeEqualToSize(CGSize.init(width: 1080/3, height: 2340/3), UIScreen.main.bounds.size)

//判断iPhone12 | 12Pro

let Device_Is_iPhone12=__CGSizeEqualToSize(CGSize.init(width: 1170/3, height: 2532/3), UIScreen.main.bounds.size)

//判断iPhone12 Pro Max

let Device_Is_iPhone12_ProMax=__CGSizeEqualToSize(CGSize.init(width: 1284/3, height: 2778/3), UIScreen.main.bounds.size)

//x系列，包含x、11、12

let Device_Is_iPhone_All=(Device_Is_iphoneX_All||Device_Is_iPhone12_Mini||Device_Is_iPhone12||Device_Is_iPhone12_ProMax)



/**

状态栏高度

*/

let StateBarHigh = Device_Is_iPhone_All ? 44:20

/**

顶部状态栏+导航高度

*/

let TopSpaceHigh = Device_Is_iPhone_All ? 88:64

/**

底部安全区域的高度

*/

let  bottomSafeHeight = Device_Is_iPhone_All ? 34:0

/**

底部区域

*/

let  bottomHeight = Device_Is_iPhone_All ? 83:49



// iPhoneX

let iPhoneX:Bool = __CGSizeEqualToSize(CGSize(width: 1125, height: 2436), UIScreen.main.currentMode?.size ?? CGSize(width: 0, height: 0));

// iPhoneXR| 11

let iPhoneXR:Bool = __CGSizeEqualToSize(CGSize(width: 828, height: 1792), UIScreen.main.currentMode?.size ?? CGSize(width: 0, height: 0));

//判断iPHoneXs | 11Pro

let iPhoneXs:Bool = __CGSizeEqualToSize(CGSize(width: 1125, height: 2436), UIScreen.main.currentMode?.size ?? CGSize(width: 0, height: 0));

// iPhoneXSMAX| 11ProMax

let iPhoneXSMAX:Bool = __CGSizeEqualToSize(CGSize(width: 1242, height: 2688), UIScreen.main.currentMode?.size ?? CGSize(width: 0, height: 0));

 

// 判断是否是X系列的

let isIPhoneX_All:Bool = iPhoneX||iPhoneXR||iPhoneXs||iPhoneXSMAX ;

//判断iPhone12_Mini

let iPhone12Mini:Bool = __CGSizeEqualToSize(CGSize(width: 1080, height: 2340), UIScreen.main.currentMode?.size ?? CGSize(width: 0, height: 0));

//判断iPhone12 | 12Pro

let iPhone12:Bool = __CGSizeEqualToSize(CGSize(width: 1170, height: 2532), UIScreen.main.currentMode?.size ?? CGSize(width: 0, height: 0));

//判断iPhone12 Pro Max

let iPhone12ProMax:Bool = __CGSizeEqualToSize(CGSize(width: 1284, height: 2778), UIScreen.main.currentMode?.size ?? CGSize(width: 0, height: 0));

//x系列，包含x、11、12

let isIPhone_All=(isIPhoneX_All||iPhone12Mini||iPhone12||iPhone12ProMax)
