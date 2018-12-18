//
//  BSBouncesContentView.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/11/28.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import Foundation
import ESTabBarController_swift

class BSBouncesContentView: BSBasicContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        iconColor = UIColor.hexadecimalColor(COLOR_NAV_BAR)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateLayout() {
        super.updateLayout()
        self.imageView.center = CGPoint.init(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0 )
    }
    
}
