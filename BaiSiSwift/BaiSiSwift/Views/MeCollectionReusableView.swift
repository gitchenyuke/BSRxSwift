//
//  MeCollectionReusableView.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/11/28.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit

class MeCollectionReusableView: UICollectionReusableView {
    
    var ivICon: UIImageView!
    var btn: UIButton!
    var bottomView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        ivICon = UIImageView.init(frame: .zero).chain
            .image(BSImaged("icon-user-img"))
            .build
        
        btn = UIButton.init(type: .custom).chain
            .font(BSFonts(FONT_BIG))
            .titleColor(UIColor.hexadecimalColor(COLOR_BLACK_TWO), for: .normal)
            .title("登陆/注册", for: .normal).build
        
        bottomView = UIView.init().chain
            .backgroundColor(BSColors(COLOR_BOTTOM)).build
        
        ViewRadius(view: ivICon, Radius: 30)
        
        self.addSubview(ivICon)
        self.addSubview(btn)
        self.addSubview(bottomView)
        
        ivICon.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(15)
            make.size.equalTo(CGSize.init(width: 60, height: 60))
        }
        
        btn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(ivICon.snp.right).offset(10)
            make.size.equalTo(CGSize.init(width: 80, height: 30))
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(self)
            make.height.equalTo(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }
}
