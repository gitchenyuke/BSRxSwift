//
//  BSNavigationViewController.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/11/6.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit

class BSNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 只对当前导航栈有效，不影响其他导航栈
        self.navigation.configuration.isEnabled = true
        /// 移除半透明
        self.navigation.configuration.isTranslucent = false
        self.navigation.configuration.barTintColor = UIColor.hexadecimalColor(COLOR_NAV_BAR)
        self.navigation.configuration.titleTextAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
        /// 设置UIBarButtonItem 图片为原色
        let backImage = BSImaged("nav_back_white").withRenderingMode(.alwaysOriginal)
        self.navigation.configuration.backImage = backImage
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count>0 {
            viewController.hidesBottomBarWhenPushed = true //跳转之后隐藏
        }
        super.pushViewController(viewController, animated: true)
    }

}
