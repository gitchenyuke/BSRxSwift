//
//  ListColumnView.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/18.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import SnapKit

class ListColumnView: UIView {

    
    var ivImage: UIImageView!
    var labCount: UILabel!
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        ivImage = UIImageView.init()
        labCount = UILabel.text(textColor: COLOR_BLACK_FOURTH, textFont: FONT_SMALL)
        
        self.addSubview(ivImage)
        self.addSubview(labCount)
        
    }
    
    func layouLeft() {
        
        ivImage.snp.makeConstraints { (make) in
            make.left.centerY.equalTo(self)
            make.size.equalTo(CGSize.init(width: 20, height: 20))
        }
        
        labCount.snp.makeConstraints { (make) in
            make.left.equalTo(ivImage.snp.right).offset(3)
            make.centerY.equalTo(self)
        }
    }
    
    func layouMid() {
        ivImage.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.centerX).offset(-1.5)
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize.init(width: 20, height: 20))
        }
        
        labCount.snp.makeConstraints { (make) in
            make.left.equalTo(ivImage.snp.right).offset(3)
            make.centerY.equalTo(self)
        }
    }
    
    func layouRight() {
        
        labCount.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(0)
            make.centerY.equalTo(self)
        }
        
        ivImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(labCount.snp.left).offset(-3)
            make.size.equalTo(CGSize.init(width: 20, height: 20))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatalError")
    }
}
