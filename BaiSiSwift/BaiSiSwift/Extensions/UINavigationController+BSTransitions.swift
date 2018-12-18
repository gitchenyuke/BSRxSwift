//
//  UINavigationController+BSTransitions.swift
//  BaiSiSwift
//
//  Created by chenyk on 2018/11/29.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    /// push转场动画
    func bs_pushViewController(_ controller:UIViewController , _ transition:UIView.AnimationTransition) {
        UIView.beginAnimations(nil, context:nil)
        self.pushViewController(controller, animated: false)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationTransition(transition, for: self.view, cache: true)
        UIView.commitAnimations()
    }
    
    /// pop
    func bs_popViewControllerWithTransition(_ transition:UIView.AnimationTransition) -> UIViewController {
        UIView.beginAnimations(nil, context:nil)
        let controller = self.popViewController(animated: false)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationTransition(transition, for: self.view, cache: true)
        UIView.commitAnimations()
        return controller!
    }
    
}
