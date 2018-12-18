//
//  BSProvider.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/11/28.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import Foundation
import UIKit
import ESTabBarController_swift

enum BSProvider {
    
    /// 自定义uitabbar
    static func customBouncesStyle() -> ESTabBarController {
        let tabBarController = ESTabBarController()
        /// 只响应中间按钮的事件回调
        tabBarController.shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 2 {
                return true
            }
            return false
        }
        /// 中间按钮点击事件
        tabBarController.didHijackHandler = {
            [weak tabBarController] tabbarController, viewController, index in
            
            let window = UIApplication.shared.keyWindow
            let view = BSComposeTypeView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
            window?.addSubview(view)
        }
        
        let v1 = EssenceViewController()
        let v2 = NewestViewController()
        let v3 = UIViewController()
        let v4 = CommunityViewController()
        let v5 = MeViewController()
        
        v1.tabBarItem = ESTabBarItem.init(BSBasicContentView(), title: "精华", image: UIImage(named: "btn_home_normal"), selectedImage: UIImage(named: "btn_home_selected"))
        v2.tabBarItem = ESTabBarItem.init(BSBasicContentView(), title: "最新", image: UIImage(named: "btn_live_normal"), selectedImage: UIImage(named: "btn_live_selected"))
        v3.tabBarItem = ESTabBarItem.init(BSBouncesContentView(), title: nil, image: UIImage(named: "btn_tabar_add"), selectedImage: UIImage(named: "btn_tabar_add"))
        v4.tabBarItem = ESTabBarItem.init(BSBasicContentView(), title: "社区", image: UIImage(named: "btn_column_normal"), selectedImage: UIImage(named: "btn_column_selected"))
        v5.tabBarItem = ESTabBarItem.init(BSBasicContentView(), title: "我", image: UIImage(named: "btn_user_normal"), selectedImage: UIImage(named: "btn_user_selected"))
        
        let nv1 = BSNavigationViewController.init(rootViewController: v1)
        let nv2 = BSNavigationViewController.init(rootViewController: v2)
        let nv3 = BSNavigationViewController.init(rootViewController: v3)
        let nv4 = BSNavigationViewController.init(rootViewController: v4)
        let nv5 = BSNavigationViewController.init(rootViewController: v5)
        
        tabBarController.viewControllers = [nv1, nv2, nv3, nv4, nv5]
        return tabBarController
    }
}

