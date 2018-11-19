//
//  RecommendListCell.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/19.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit

class RecommendListCell: BSBaseTableViewCell {

    var labContent: UILabel!
    var bgView: UIView!
    
    override func setupUI() {
        
        bgView = UIView.init()
        bgView.backgroundColor = UIColor.hexadecimalColor(COLOR_BOTTOM)
        
        labContent = UILabel.text(textColor: COLOR_BLACK_THREE, textFont: FONT_MIDDLE)
        labContent.numberOfLines = 0

        contentView.addSubview(bgView)
        bgView.addSubview(labContent)
    }
    
    func reloadData(data:Top_commentsEntity) -> Void {
        
        let attributedText = self.contentAttributedText(data: data)
        let hight = self.contextHight(attributedText: attributedText)
        labContent.attributedText = attributedText
        bgView.frame = CGRect(x: 15, y: 0, width: kScreenWidth - 30, height: hight + 8)
        labContent.frame = CGRect(x: 15, y: 8, width: kScreenWidth - 60, height: hight)
    }
    
    static func getCellHightData(data:Top_commentsEntity) -> CGFloat {
        let attributedText = self.init().contentAttributedText(data: data)
        let hight = self.init().contextHight(attributedText: attributedText)
        return hight + 8
    }
    
    func contentAttributedText(data:Top_commentsEntity) -> NSMutableAttributedString {
        let content = String.init(format: "%@: %@", data.u?.name ?? "" , data.content ?? "")
        let attributedText = NSMutableAttributedString.attributenStringColor(text: content, selectedText: data.u?.name ?? "", allColor: UIColor.hexadecimalColor(COLOR_BLACK_THREE), selectedColor: UIColor.hexadecimalColor(COLOR_BLUE), fone: FONT_MIDDLE)
        return attributedText
    }
    
    func contextHight(attributedText:NSMutableAttributedString) -> CGFloat {
        let hight = String.getAttributedStrH(attriStr: attributedText, strFont: FONT_MIDDLE, w: kScreenWidth - 60)
        return hight
    }
}
