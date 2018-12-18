//
//  BSBasicContentView.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/11/28.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class BSBasicContentView: ESTabBarItemContentView {
    
    public var duration = 0.3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = UIColor.hexadecimalColor(COLOR_BLACK_THREE)
        highlightTextColor = UIColor.hexadecimalColor(COLOR_NAV_BAR)
        iconColor = UIColor.hexadecimalColor(COLOR_BLACK_THREE)
        highlightIconColor = UIColor.hexadecimalColor(COLOR_NAV_BAR)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func selectAnimation(animated: Bool, completion: (() -> ())?) {
        self.bounceAnimation()
        completion?()
    }
    
    override func reselectAnimation(animated: Bool, completion: (() -> ())?) {
        self.bounceAnimation()
        completion?()
    }
    
    /// 点击增加抖动
    func bounceAnimation() {
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        impliesAnimation.duration = duration * 2
        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
        imageView.layer.add(impliesAnimation, forKey: nil)
    }
    
    /// 重写layout
    override func updateLayout() {
        super.updateLayout()
        self.imageView.sizeToFit()
        self.imageView.center = CGPoint.init(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0 - 5)
        self.titleLabel.center = CGPoint.init(x: self.bounds.size.width / 2.0, y: self.bounds.size.height - 10)
    }
    
}
