//
//  BSMarco.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/15.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import Foundation
import UIKit

// View
//当前视图的view
let kRootView = UIApplication.shared.keyWindow?.rootViewController?.view

let kScreenWidth:CGFloat                     = UIScreen.main.bounds.size.width
let kScreenHeight:CGFloat                    = UIScreen.main.bounds.size.height

//字体大小
let FONT_BIG:CGFloat                         =  18.0
let FONT_MIDDLE:CGFloat                      =  15.0
let FONT_SMALL:CGFloat                       =  12.0
let FONT_SPECIAL:CGFloat                     =  22.0


//背景颜色
let COLOR_BOTTOM                             = "#F3F3F3"   //背景灰色
let COLOR_BOTTOM_TWO                         = "#F5F5F5"   //浅灰色
let COLOR_BOTTOM_THREE                       = "#FBFBFB"    //浅蓝色
let COLOR_NAV_BAR                            = "#EB445A"    //导航栏背景颜色

//字体颜色
let COLOR_LINE                               = "#DEDEDE"   //线条颜色
let COLOR_BLACK_ONE                          = "#36363B"   //四种黑色字体,有深到浅
let COLOR_BLACK_TWO                          = "#505050"
let COLOR_BLACK_THREE                        = "#787878"
let COLOR_BLACK_FOURTH                       = "#969696"
let COLOR_GREEN                              = "#32c1b4"  //绿色字体
let COLOR_BLUE                               = "#1e82d2"  //蓝色字体
let COLOR_ORANGE                             = "#F76859"  //橘色字体

let PlaceholderImage1                        = "defaultGraph_1"
let PlaceholderImage2                        = "defaultGraph_2"
let PlaceholderImage3                        = "defaultGraph_3"

/// iphoneX机型
let IsIphoneX                                = UIApplication.shared.statusBarFrame.size.height == 44
/// 导航栏高度
let SafeAreaTopHeight:CGFloat                = IsIphoneX ? 88 : 64
/// tabbar 高度
let SafeAreaBottomHeight:CGFloat             = IsIphoneX ? 83 : 49

let Nav_Top:CGFloat                          = IsIphoneX ? 44 : 20;

let SdcylesScrollViewHeight:CGFloat          = 200
let FindFristHeaderCollectionMager:CGFloat   = kScreenWidth/9

let XHLinkCollectionViewCellW:CGFloat        = (kScreenWidth-40 - 70)/3

let DefaultGraph:String                      = "defaultGraph_2" //图片默认占位图
let MeCellWithd:CGFloat                      = (kScreenWidth - 130) / 5.0


// View 圆角和加边框
func ViewBorderRadius(view:UIView ,Radius:CGFloat ,Width:CGFloat,Color:UIColor) {
    view.layer.cornerRadius = Radius
    view.layer.masksToBounds = true
    view.layer.borderWidth = Width
    view.layer.borderColor = Color.cgColor
}

/// View 倒圆角
func ViewRadius(view:UIView ,Radius:CGFloat) {
    view.layer.cornerRadius = Radius
    view.layer.masksToBounds = true
}

/// 图片
func BSImaged(_ string:String) -> UIImage {
    return UIImage.init(named: string)!
}

/// 字体
func BSFonts(_ font:CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: font)
}
/// 字体加粗
func BSFontb(_ font:CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: font)
}

/// 颜色
func BSColors(_ hexadecimalColor:String) -> UIColor {
    return UIColor.hexadecimalColor(hexadecimalColor)
}

/// 占位图
func BSPlaceholderImage() -> UIImage {
    return UIImage.init(named: PlaceholderImage2)!
}


