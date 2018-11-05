//
//  BSComposeTypeViewController.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/23.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import pop

class BSComposeTypeViewController: UIViewController {
    
    private let buttonsInfo = [["imageName": "tabbar_compose_idea", "title": "文字" ],
                               ["imageName": "tabbar_compose_photo", "title": "照片/视频"],
                               ["imageName": "tabbar_compose_weibo", "title": "长微博"],
                               ["imageName": "tabbar_compose_lbs", "title": "签到"],
                               ["imageName": "tabbar_compose_review", "title": "点评"],
                               ["imageName": "tabbar_compose_more", "title": "更多"]]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.gray
        
        addButtons()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideButtons()
    }
    

    /// 弹出按钮
    func showButtons() {
        
        /// 正向遍历
        for (i , btn) in view.subviews.enumerated() {
            // 创建动画
            let anim: POPSpringAnimation = POPSpringAnimation.init(propertyNamed: kPOPLayerPositionY)
            
            anim.fromValue = btn.center.y
            anim.toValue = btn.center.y - 350
            
            // 弹力系数，取值范围 0~20，数值越大，弹性越大，默认数值为4
            anim.springBounciness = 6
            // 弹力速度，取值范围 0~20，数值越大，速度越快，默认数值为12
            anim.springSpeed = 6
            
            // 设置动画启动时间
            anim.beginTime = CACurrentMediaTime() + CFTimeInterval.init(i) * 0.025
            
            btn.pop_add(anim, forKey: nil)
        }
    }
    

    func addButtons() {
        
        let buttonSize = CGSize.init(width: 100, height: 100)
        let margin = (kScreenWidth - 3 * buttonSize.width)/4
        
        for i in 0..<buttonsInfo.count {
            
            let dict = buttonsInfo[i]
            guard let imageName = dict["imageName"],
                let title = dict["title"] else {
                    continue
            }
            
            let button = BSComposeTypeButton.initTypeButton(imageName:imageName,title:title)
            view.addSubview(button)
            
            
            let col = i % 3
            let row = i / 3
            
            let margin2 = col>0 ? margin : 0
            
            let x = margin + (buttonSize.width + margin2) * CGFloat(col)
            
            let y = row > 0 ? (kScreenHeight + (buttonSize.height + 20) * CGFloat(row)) : kScreenHeight
            
            button.frame = CGRect(x: x, y: y, width: buttonSize.width, height: buttonSize.height)
            
        }
        
        showButtons()
    }
    
    /// 隐藏按钮
    func hideButtons() {
        
        // 反向遍历
        for (i , btn) in view.subviews.enumerated().reversed() {
            // 创建动画
            let anim: POPSpringAnimation = POPSpringAnimation.init(propertyNamed: kPOPLayerPositionY)
            anim.fromValue = btn.center.y
            anim.toValue = btn.center.y + 350
            
            // 弹力系数，取值范围 0~20，数值越大，弹性越大，默认数值为4
            anim.springBounciness = 6
            // 弹力速度，取值范围 0~20，数值越大，速度越快，默认数值为12
            anim.springSpeed = 6
            
            // 设置动画时间
            anim.beginTime = CACurrentMediaTime() + CFTimeInterval(view.subviews.count - i) * 0.025
            
            btn.layer.pop_add(anim, forKey: nil)
            
            if i == 0 {
                anim.completionBlock = { _, _ in
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
