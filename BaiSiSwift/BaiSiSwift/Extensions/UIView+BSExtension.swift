//
//  UIView+BSExtension.swift
//  BaiSiSwift
//
//  Created by chenyk on 2018/12/26.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit

extension UIView {
    
    /// 以后用这两个方法代替之前的宏
    
    // MARK:- 裁剪圆角
    func clipCorner(direction: UIRectCorner, radius: CGFloat) {
        
        let cornerSize = CGSize(width: radius, height: radius)
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: direction, cornerRadii: cornerSize)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.addSublayer(maskLayer)
        layer.mask = maskLayer
    }
    
    
    /// 圆角加边框
    ///
    /// - Parameters:
    ///   - Radius: 倒角
    ///   - Width: 边框大小
    ///   - Color: 边框颜色
    func viewBorderRadius(Radius:CGFloat ,Width:CGFloat,Color:UIColor) {
        layer.cornerRadius = Radius
        layer.masksToBounds = true
        layer.borderWidth = Width
        layer.borderColor = Color.cgColor
    }
    
}

