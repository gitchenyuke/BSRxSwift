//
//  BSBaseViewController.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/15.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit

class BSBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.white
        
    }
    
    /// 设置精华 最新导航栏
    func setUpNavigation() {
        
        let leftButton = creatButton(imageStr: "iv_nav_left")
        let rightButton = creatButton(imageStr: "iv_nav_right")
        
        leftButton.addTarget(self, action: #selector(self.leftItemClick), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(self.rightItemClick), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightButton)

        let lab = UILabel.textColor(textColor: UIColor.white, textFont: FONT_MIDDLE)
        lab.frame = CGRect(x: 0, y: 0, width: 120, height: 20)
        lab.textAlignment = NSTextAlignment.center
        lab.text = "百思不得姐"
        navigationItem.titleView = lab
    }
    
    func creatButton(imageStr:String) -> UIButton {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.setImage(BSImaged(imageStr), for: .normal)
        return button
    }
    
    @objc func rightItemClick() {
        print("rightItem click")
        
    }
    
    @objc func leftItemClick() {
        print("leftItem Click")
    }

}
