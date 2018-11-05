//
//  NavProtocol.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/16.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import Foundation
import UIKit

/// 隐藏导航栏分割线协议
protocol ShadowNavImageLine {
    
}

/// 实现隐藏方法
extension ShadowNavImageLine where Self : UIViewController {
    func hiddenLine() {
        /// 隐藏导航栏分割线
        navigationController?.navigationBar.shadowImage = UIImage.init()
        navigationController?.navigationBar.backgroundImage(for: .default)
    }
}

