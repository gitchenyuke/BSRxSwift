//
//  UILabel+BSExtension.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/15.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import Foundation
import UIKit

/// UILabel 同时设置字体颜色和大小
extension UILabel{
    
    // 颜色字符串
    class func text(textColor:String,textFont:CGFloat) -> UILabel{
        let color = UIColor.hexadecimalColor(textColor)
        let font = UIFont.systemFont(ofSize: textFont)
        let lab = UILabel.init()
        lab.textColor = color
        lab.font = font
        return lab
    }
    
    // 传入颜色
    class func textColor(textColor:UIColor,textFont:CGFloat) -> UILabel{
        let font = UIFont.systemFont(ofSize: textFont)
        let lab = UILabel.init()
        lab.textColor = textColor
        lab.font = font
        return lab
    }
}
