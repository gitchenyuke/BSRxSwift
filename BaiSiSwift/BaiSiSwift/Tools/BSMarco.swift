//
//  BSMarco.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/15.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import Foundation
import UIKit

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

let SafeAreaTopHeight:CGFloat                = kScreenHeight == 812.0 ? 88 : 64
let SafeAreaBottomHeight:CGFloat             = kScreenHeight == 812.0 ? 83 : 49

let SdcylesScrollViewHeight:CGFloat          = 200
let FindFristHeaderCollectionMager:CGFloat   = kScreenWidth/9

let XHLinkCollectionViewCellW:CGFloat        = (kScreenWidth-40 - 70)/3

let DefaultGraph:String = "defaultGraph_2" //图片默认占位图


// View 圆角和加边框
func ViewBorderRadius(view:UIView ,Radius:CGFloat ,Width:CGFloat,Color:UIColor) {
    view.layer.cornerRadius = Radius
    view.layer.masksToBounds = true
    view.layer.borderWidth = Width
    view.layer.borderColor = Color.cgColor
}

// View 倒圆角
func ViewRadius(view:UIView ,Radius:CGFloat) {
    view.layer.cornerRadius = Radius
    view.layer.masksToBounds = true
}

func BSImaged(_ string:String) -> UIImage {
    return UIImage.init(named: string)!
}

func BSPlaceholderImage() -> UIImage {
    return UIImage.init(named: PlaceholderImage2)!
}


