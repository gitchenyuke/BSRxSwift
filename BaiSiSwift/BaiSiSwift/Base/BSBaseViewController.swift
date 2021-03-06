//
//  BSBaseViewController.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/15.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BSBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        /// 隐藏分割线
        navigation.bar.isShadowHidden = true
        
        /// 自定义返回 图片往左移一点
        //setBackButtonItem()
    }
    
    
    /// 自定义返回 图片往左移一点
//    func setBackButtonItem() {
//        if (self.navigationController?.viewControllers.count)! > 1 {
//            let backButton = UIButton(type: .custom).chain.frame(CGRect(x: 0, y: 0, width: 44, height: 44)).build
//            backButton.setImage(BSImaged("nav_back_white"), for: .normal)
//            backButton.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -30, bottom: 0, right: 0)
//            backButton.addTarget(self, action: #selector(backBarButtonAction), for: .touchUpInside)
//            navigation.item.leftBarButtonItem = UIBarButtonItem(customView: backButton)
//        }
//    }
   
//    @objc func backBarButtonAction() {
//        self.navigationController?.popViewController(animated: true)
//    }
    
    /// 设置精华 最新导航栏
    func setUpNavigation() {
        
        let leftButton = creatButton(imageStr: "iv_nav_left")
        let rightButton = creatButton(imageStr: "iv_nav_right")
        
        navigation.item.leftBarButtonItem = UIBarButtonItem.init(customView: leftButton)
        navigation.item.rightBarButtonItem = UIBarButtonItem.init(customView: rightButton)
        
        leftButton.addTarget(self, action: #selector(self.leftItemClick), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(self.rightItemClick), for: .touchUpInside)

    }
    
    func creatButton(imageStr:String) -> UIButton {
        
        let button = UIButton
            .init(type: .custom)
            .chain.frame(CGRect(x: 0, y: 0, width: 44, height: 44))
            .image(BSImaged(imageStr), for: .normal)
            .build
        return button
    }
    
    @objc func rightItemClick() {
        print("rightItem click")
        
    }
    
    @objc func leftItemClick() {
        print("leftItem Click")
    }

}
