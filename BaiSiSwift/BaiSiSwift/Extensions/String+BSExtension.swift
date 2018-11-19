//
//  String+BSExtension.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/15.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import Foundation
import UIKit

/**获取字符串尺寸--私有方法*/
private func getNormalStrSize(str: String? = nil, attriStr: NSMutableAttributedString? = nil, font: CGFloat, w: CGFloat, h: CGFloat) -> CGSize {
    if str != nil {
        let strSize = (str! as NSString).boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: font)], context: nil).size
        return strSize
    }
    
    if attriStr != nil {
        let strSize = attriStr!.boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, context: nil).size
        return strSize
    }
    
    return CGSize.zero
    
}

extension String {
    
//    var api : APIManager {
//        switch self {
//        case "推荐":
//            return .jhrecommend(json: "0-20.json")
//        case "视频":
//            return .jhvideo(json: "0-20.json")
//        case "图片":
//            return .jhimage(json: "0-20.json")
//        case "笑话":
//            return .jhremen(json: "0-20.json")
//        case "排行":
//            return .jhremen(json: "0-20.json")
//        default:
//            return .jhrecommend(json: "0-20.json")
//        }
//    }
    
    static func jhRequest(type:String , json:String) -> APIManager {
        switch type {
        case "推荐":
            return .jhrecommend(json: json)
        case "视频":
            return .jhvideo(json: json)
        case "图片":
            return .jhimage(json: json)
        case "笑话":
            return .jhjoke(json: json)
        case "排行":
            return .jhremen(json: json)
        default:
            return .jhrecommend(json: json)
        }
    }
}

extension String {
    /**获取字符串高度H*/
    static func getNormalStrH(str: String, strFont: CGFloat, w: CGFloat) -> CGFloat {
        return getNormalStrSize(str: str, font: strFont, w: w, h: CGFloat.greatestFiniteMagnitude).height
    }
    
    /**获取字符串宽度W*/
    static func getNormalStrW(str: String, strFont: CGFloat, h: CGFloat) -> CGFloat {
        return getNormalStrSize(str: str, font: strFont, w: CGFloat.greatestFiniteMagnitude, h: h).width
    }
    
    /**获取富文本字符串高度H*/
    static func getAttributedStrH(attriStr: NSMutableAttributedString, strFont: CGFloat, w: CGFloat) -> CGFloat {
        return getNormalStrSize(attriStr: attriStr, font: strFont, w: w, h: CGFloat.greatestFiniteMagnitude).height
    }
    
    /**获取富文本字符串宽度W*/
    static func getAttributedStrW(attriStr: NSMutableAttributedString, strFont: CGFloat, h: CGFloat) -> CGFloat {
        return getNormalStrSize(attriStr: attriStr, font: strFont, w: CGFloat.greatestFiniteMagnitude, h: h).width
    }
}

extension NSMutableAttributedString {
    
    //MARK: 选中字体颜色变红
    /// - Parameters:
    ///   - text: 所有字符串
    ///   - selectedText: 需要变颜色的字符串
    ///   - allColor: 字符串本来颜色
    ///   - selectedColor: 选中字符串颜色
    ///   - fone: 字符串字体大小
    /// - Returns: 返回一个NSMutableAttributedString
    static func attributenStringColor(text:String,
                                      selectedText: String,
                                      allColor: UIColor,
                                      selectedColor: UIColor,
                                      fone: CGFloat)->NSMutableAttributedString{
        var rangeArray: [NSRange] = [NSRange]()
        var lastLength: Int = 0
        let attStr = NSMutableAttributedString.init(string: text, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: fone),NSAttributedString.Key.foregroundColor:allColor])
        var text = text as NSString
        
        while text.contains(selectedText) {
            let rang: NSRange =  text.range(of: selectedText)
            let rang2 = NSMakeRange(rang.location + lastLength, rang.length)
            rangeArray.append(rang2)
            lastLength += (rang.length + rang.location )
            text = text.substring(from: rang.length + rang.location) as NSString
        }
        
        for range1 in rangeArray {
            attStr.setAttributes([NSAttributedString.Key.foregroundColor:selectedColor], range: range1)
        }
        
        return attStr
    }
    
    
    //MARK: 指定两个字符中间文字变色
    ///
    /// - Parameters:
    ///   - text: 所有字符串
    ///   - allColor: 基础颜色
    ///   - selectedColor: 特殊颜色
    ///   - firstStr: 其实字符串
    ///   - lastStr: 结束字符串
    ///   - fone: 基础字体
    /// - Returns: NSMutableAttributedString
    static func attributenStringMutColor(text:String,
                                         allColor: UIColor,
                                         selectedColor: UIColor,
                                         firstStr : String,
                                         lastStr : String,
                                         fone: CGFloat)->NSMutableAttributedString{
        
        var rangeArray: [NSRange] = [NSRange]()
        var lastLength: Int = 0
        let attStr = NSMutableAttributedString.init(string: text, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: fone),NSAttributedString.Key.foregroundColor:allColor])
        var text = text as NSString
        
        while text.contains(firstStr) {
            let rang1: NSRange =  text.range(of: firstStr)
            let range2: NSRange =  text.range(of: lastStr)
            let orangeRange = NSMakeRange(rang1.location + 1, range2.location - (rang1.location + 1))
            let range = NSMakeRange(rang1.location + 1 + lastLength , range2.location - (rang1.location + 1) )
            rangeArray.append(range)
            lastLength += (orangeRange.length + orangeRange.location + 1)
            text = text.substring(from: orangeRange.length + orangeRange.location + 1) as NSString
        }
        
        for range1 in rangeArray {
            attStr.setAttributes([NSAttributedString.Key.foregroundColor:UIColor.red], range: range1)
        }
        
        return attStr
    }
    
    
    //MARK: 行间距
    ///
    /// - Parameters:
    ///   - text: 整体字符串
    ///   - lineSpace: 行间距
    ///   - fone: 字图
    /// - Returns: NSMutableAttributedString
    static func lineSpace(text: String,lineSpace: CGFloat,fone: CGFloat)->NSMutableAttributedString{
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        let attStr = NSMutableAttributedString.init(string: text, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: fone)])
        attStr.addAttributes([NSAttributedString.Key.foregroundColor : paragraphStyle], range: NSMakeRange(0, text.count))
        
        return attStr
    }
    
    
    /// 可变字体
    ///
    /// - Parameters:
    ///   - text: 整体字符串
    ///   - selectedText: 选中字符串
    ///   - allFont: 基础字体
    ///   - selectedFont: 变化字体
    ///   - textColor: 字符串颜色
    /// - Returns: NSMutableAttributedString
    static func attributenStringFont(text:String,
                                     selectedText: String,
                                     allFont: CGFloat,
                                     selectedFont: CGFloat,
                                     textColor: UIColor)->NSMutableAttributedString{
        var rangeArray: [NSRange] = [NSRange]()
        var lastLength: Int = 0
        let attStr = NSMutableAttributedString.init(string: text, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: allFont),NSAttributedString.Key.foregroundColor:textColor])
        var text = text as NSString
        
        while text.contains(selectedText) {
            let rang: NSRange =  text.range(of: selectedText)
            let rang2 = NSMakeRange(rang.location + lastLength, rang.length)
            rangeArray.append(rang2)
            lastLength += (rang.length + rang.location )
            text = text.substring(from: rang.length + rang.location) as NSString
        }
        
        for range1 in rangeArray {
            //NSForegroundColorAttributeName:UIColor.red 去掉后就没特殊颜色了
            attStr.setAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: selectedFont),NSAttributedString.Key.foregroundColor:UIColor.red], range: range1)
        }
        
        return attStr
    }
    
}
