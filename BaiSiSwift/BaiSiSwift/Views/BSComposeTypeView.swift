//
//  BSComposeTypeView.swift
//  BaiSiSwift
//
//  Created by chenyk on 2018/11/29.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import pop

fileprivate let kAnimationDelay = 0.025
fileprivate let kSpringFactor: CGFloat = 6

class BSComposeTypeView: UIView {
    
    private let buttonsInfo = [["imageName": "tabbar_compose_idea", "title": "文字" ],
                               ["imageName": "tabbar_compose_photo", "title": "照片/视频"],
                               ["imageName": "tabbar_compose_weibo", "title": "长微博"],
                               ["imageName": "tabbar_compose_lbs", "title": "签到"],
                               ["imageName": "tabbar_compose_review", "title": "点评"],
                               ["imageName": "tabbar_compose_more", "title": "更多"]]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        /// 添加毛玻璃效果
        let blur = UIBlurEffect.init(style: .light)
        /// 毛玻璃视图
        let visual = UIVisualEffectView.init(effect: blur).chain.frame(self.bounds).build
        self.addSubview(visual)
        
        addTitle()
        addButtons()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideButtons()
    }
    
    /// 弹出按钮
    func showButtons() {
        
        /// 正向遍历
        for (i , btn) in self.subviews.enumerated() {
            
            if btn.isKind(of: BSComposeTypeButton.self) || btn.isKind(of: UILabel.self)  {
                // 创建动画
                let anim: POPSpringAnimation = POPSpringAnimation.init(propertyNamed: kPOPLayerPositionY)
                
                // 弹力系数，取值范围 0~20，数值越大，弹性越大，默认数值为4
                anim.springBounciness = kSpringFactor
                // 弹力速度，取值范围 0~20，数值越大，速度越快，默认数值为12
                anim.springSpeed = kSpringFactor
                
                // 设置动画启动时间
                anim.beginTime = CACurrentMediaTime() + CFTimeInterval.init(i) * kAnimationDelay
                
                btn.pop_add(anim, forKey: nil)
                anim.fromValue = btn.center.y
                anim.toValue = btn.center.y - kScreenHeight / 2 - 70
            }
        }
    }
    
    /// 标题
    func addTitle() {
        let labTitle = UILabel.init(frame: CGRect(x: 0, y: kScreenHeight, width: kScreenWidth, height: 30)).chain
            .textAlignment(.center)
            .textColor(BSColors(COLOR_BLACK_THREE))
            .font(BSFontb(FONT_SPECIAL))
            .text("让精彩填满生活!").build
        
        self.addSubview(labTitle)
    }
    
    /// 添加按钮
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
            self.addSubview(button)
            
            let col = i % 3
            let row = i / 3
            
            let margin2 = col>0 ? margin : 0
            
            let x = margin + (buttonSize.width + margin2) * CGFloat(col)
            /// + 70 是labTitle的高度30 + 距离button间隔 40
            let y = row > 0 ? (kScreenHeight + 70 + (buttonSize.height + 20) * CGFloat(row)) : kScreenHeight + 70
            button.frame = CGRect(x: x, y: y, width: buttonSize.width, height: buttonSize.height)
        }
        showButtons()
    }
    
    /// 隐藏按钮
    func hideButtons() {
        /// 执行动画时设置相关view不能被点击
        kRootView?.isUserInteractionEnabled = false
        isUserInteractionEnabled = false
        
        // 反向遍历
        for (i , btn) in self.subviews.enumerated().reversed() {
            
            if btn.isKind(of: BSComposeTypeButton.self) || btn.isKind(of: UILabel.self) {
                // 创建动画
                let anim: POPSpringAnimation = POPSpringAnimation.init(propertyNamed: kPOPLayerPositionY)
                
                anim.fromValue = btn.center.y
                anim.toValue = btn.center.y + kScreenHeight / 2 + 70
                
                // 弹力系数，取值范围 0~20，数值越大，弹性越大，默认数值为4
                anim.springBounciness = kSpringFactor
                // 弹力速度，取值范围 0~20，数值越大，速度越快，默认数值为12
                anim.springSpeed = kSpringFactor
                
                // 设置动画时间
                anim.beginTime = CACurrentMediaTime() + CFTimeInterval(self.subviews.count - i) * kAnimationDelay
                
                btn.layer.pop_add(anim, forKey: nil)
                
                if i == 1 { // 因为添加了visual毛玻璃 所以self.subviews.count 多了1
                    anim.completionBlock = { _, _ in
                        /// 动画执行完毕 当前view设为可点击
                        kRootView?.isUserInteractionEnabled = true
                        self.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }

}
