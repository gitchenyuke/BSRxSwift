//
//  ListCommunityView.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/11/1.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit

class ListCommunityView: UIView {
    
    var topLine: UIImageView!
    var bottomLine: UIImageView!
    var ivIcon: UIImageView!
    var labTitle: UILabel!
    var labSubTitle1: UILabel!
    var labSubTitle2: UILabel!
    var btnPush: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        topLine = UIImageView.init()
        bottomLine = UIImageView.init()
        ivIcon = UIImageView.init()
        btnPush = UIButton.init()
        labTitle = UILabel.text(textColor: COLOR_BLACK_TWO, textFont: FONT_BIG)
        labSubTitle1 = UILabel.text(textColor: COLOR_BLACK_FOURTH, textFont: FONT_SMALL)
        labSubTitle2 = UILabel.text(textColor: COLOR_BLACK_FOURTH, textFont: FONT_SMALL)
        
        btnPush.titleLabel?.font = UIFont.systemFont(ofSize: FONT_MIDDLE)
        btnPush.setTitleColor(UIColor.white, for: .normal)
        btnPush.setTitle("进入", for: .normal)
        ViewRadius(view: btnPush, Radius: 13)
        btnPush.backgroundColor = UIColor.hexadecimalColor(hexadecimal: COLOR_NAV_BAR)
        
        topLine.backgroundColor = UIColor.hexadecimalColor(hexadecimal: COLOR_BOTTOM)
        bottomLine.backgroundColor = UIColor.hexadecimalColor(hexadecimal: COLOR_BOTTOM)
        
        self.addSubview(topLine)
        self.addSubview(bottomLine)
        self.addSubview(ivIcon)
        self.addSubview(labTitle)
        self.addSubview(labSubTitle1)
        self.addSubview(labSubTitle2)
        self.addSubview(btnPush)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        topLine.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self)
            make.height.equalTo(10)
        }
        
        bottomLine.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(self)
            make.height.equalTo(10)
        }
        
        ivIcon.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(15)
            make.size.equalTo(CGSize.init(width: 70, height: 70))
        }
        
        labTitle.snp.makeConstraints { (make) in
            make.top.equalTo(ivIcon)
            make.left.equalTo(ivIcon.snp.right).offset(10)
        }
        
        labSubTitle1.snp.makeConstraints { (make) in
            make.centerY.equalTo(ivIcon)
            make.right.equalTo(-70)
            make.left.equalTo(ivIcon.snp.right).offset(10)
        }
        
        labSubTitle2.snp.makeConstraints { (make) in
            make.bottom.equalTo(ivIcon)
            make.right.equalTo(-70)
            make.left.equalTo(ivIcon.snp.right).offset(10)
        }
        
        btnPush.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(-10)
            make.size.equalTo(CGSize.init(width: 50, height: 26))
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
