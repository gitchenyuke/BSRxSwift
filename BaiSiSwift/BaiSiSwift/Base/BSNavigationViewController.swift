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

        // Do any additional setup after loading the view.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count>0 {
            viewController.hidesBottomBarWhenPushed = true //跳转之后隐藏
        }
        super.pushViewController(viewController, animated: true)
    }

}
