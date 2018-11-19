//
//  ListFooterSctionView.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/19.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import SnapKit

class ListFooterSctionView: UIView {

    var bgView: UIView!
    var line: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bgView = UIView.init()
        line = UIImageView.init()
        
        bgView.backgroundColor = UIColor.hexadecimalColor(COLOR_BOTTOM)
        line.backgroundColor = UIColor.hexadecimalColor(COLOR_LINE)
        
        self.addSubview(bgView)
        self.addSubview(line)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bgView.snp.makeConstraints { (make) in
            make.centerX.top.equalTo(self)
            make.size.equalTo(CGSize.init(width: kScreenWidth - 30, height: 8))
        }
        
        line.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self)
            make.height.equalTo(0.5)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatalError")
    }
}
