//
//  MeCollectionViewCell.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/11/29.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit

class MeCollectionViewCell: BSBaseCollectionViewCell {
    
    var ivCover: UIImageView!
    var labTitle: UILabel!
    
    override func setupUI() {
        super.setupUI()
        
        ivCover = UIImageView.init().chain.backgroundColor(BSColors(COLOR_BOTTOM)).build
        labTitle = UILabel.init().chain.font(BSFonts(FONT_SMALL)).textColor(BSColors(COLOR_BLACK_TWO)).build
        
        ViewRadius(view: ivCover, Radius: MeCellWithd / 2.0)
        
        contentView.addSubview(ivCover)
        contentView.addSubview(labTitle)
        
        ivCover.snp.makeConstraints { (make) in
            make.top.centerX.equalTo(contentView)
            make.size.equalTo(CGSize.init(width: MeCellWithd, height: MeCellWithd))
        }
        
        labTitle.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(ivCover.snp.bottom).offset(5)
        }
        
    }
    
}
