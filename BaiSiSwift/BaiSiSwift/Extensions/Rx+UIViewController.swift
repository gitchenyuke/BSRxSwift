//
//  Rx+UIViewController.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/11/28.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import RxSwift
import RxCocoa

public extension Reactive where Base: UIViewController {
    
    func push(_ viewController: @escaping @autoclosure () -> UIViewController,
              animated: Bool = true)
        -> Binder<Void>
    {
        return Binder(base) { this, _ in
            this.navigationController?.pushViewController(viewController(), animated: animated)
        }
    }
    
    func pop(animated: Bool = true) -> Binder<Void> {
        return Binder(base) { this, _ in
            this.navigationController?.popViewController(animated: animated)
        }
    }
    
    func popToRoot(animated: Bool = true) -> Binder<Void> {
        return Binder(base) { this, _ in
            this.navigationController?.popToRootViewController(animated: animated)
        }
    }
    
    func present(_ viewController: @escaping @autoclosure () -> UIViewController,
                 animated: Bool = true,
                 completion: (() -> Void)? = nil)
        -> Binder<Void>
    {
        return Binder(base) { this, _ in
            this.present(viewController(), animated: animated, completion: completion)
        }
    }
    
    func dismiss(animated: Bool = true) -> Binder<Void> {
        return Binder(base) { this, _ in
            this.dismiss(animated: animated, completion: nil)
        }
    }
}


///获取当前控制器
func currentVc() ->UIViewController{
    
    var vc = UIApplication.shared.keyWindow?.rootViewController
    
    if (vc?.isKind(of: UITabBarController.self))! {
        vc = (vc as! UITabBarController).selectedViewController
    }else if (vc?.isKind(of: UINavigationController.self))!{
        vc = (vc as! UINavigationController).visibleViewController
    }else if ((vc?.presentedViewController) != nil){
        vc =  vc?.presentedViewController
    }
    return vc!
}

