//
//  BSLoginWithRegiestController.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/11/21.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import EachNavigationBar

class BSLoginWithRegiestController: UIViewController {
    
    lazy var loginVC: BSLoginViewController = {
        let loginVC = BSLoginViewController()
        loginVC.view.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight-SafeAreaTopHeight)
        return loginVC
    }()
    
    lazy var regiestVC: BSRegiestViewController = {
        let regiestVC = BSRegiestViewController()
        regiestVC.view.frame = CGRect(x: kScreenWidth, y: 0, width: kScreenWidth, height: kScreenHeight-SafeAreaTopHeight)
        return regiestVC
    }()

    lazy var scrollView: UIScrollView = {
        UIScrollView.init(frame: CGRect(x: 0, y: SafeAreaTopHeight, width: kScreenWidth, height: kScreenHeight-SafeAreaTopHeight)).chain
            .contentSize(CGSize.init(width: kScreenWidth*2, height: kScreenHeight-SafeAreaTopHeight))
            .isScrollEnabled(false)
            .build
    }()
    
    lazy var imageView: UIImageView = {
        UIImageView.init(frame: view.bounds).chain.image(BSImaged("iv_bg.jpg")).build
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// 添加毛玻璃效果
        let blur = UIBlurEffect.init(style: .light)
        /// 毛玻璃视图
        let visual = UIVisualEffectView.init(effect: blur).chain.frame(view.bounds).build
        
        imageView.addSubview(visual)
        view.addSubview(imageView)
        view.addSubview(scrollView)
        scrollView.addSubview(loginVC.view)
        scrollView.addSubview(regiestVC.view)
        
        //view.backgroundColor = UIColor.hexadecimalColor(COLOR_BOTTOM)
        view.backgroundColor = UIColor.gray
        /// 隐藏导航栏
        navigation.bar.isHidden = true
        
        let backButton = UIButton.init(type: .custom).chain
            .frame(CGRect(x: 15, y: Nav_Top, width: 44, height: 44))
            .image(BSImaged("iv_close"), for: .normal)
            .build
        
        let regiestButton = UIButton.init(type: .custom).chain
            .frame(CGRect(x: kScreenWidth - 15 - 80, y: Nav_Top, width: 80, height: 44))
            .title("注册账号", for: .normal)
            .title("已有账号", for: .selected)
            .titleColor(UIColor.white, for: .normal)
            .titleColor(UIColor.white, for: .selected)
            .systemFont(ofSize: FONT_BIG)
            .build
        
        //share(replay: 1, scope: .forever) 订阅了多次信号只会进行一次操作
        //tap点击时设置isSelected 属性
        let isSelected = regiestButton.rx.tap
            .map(to: !regiestButton.isSelected)
            .share(replay: 1, scope: .forever)
        
        /// isSelected 绑定 regiestButton.rx.isSelected
        isSelected.bind(to: regiestButton.rx.isSelected).disposed(by: rx.disposeBag)
        
        view.addSubview(backButton)
        view.addSubview(regiestButton)
        
        backButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: rx.disposeBag)
        
        regiestButton.rx.tap.subscribe(onNext: { [weak self]  in
            regiestButton.isSelected ? self?.scrollView.setContentOffset(CGPoint.init(x: kScreenWidth, y: 0), animated: true):
                                       self?.scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
        }).disposed(by: rx.disposeBag)
        
        NotificationCenter.default.rx
            .notification(Notification.Name("popLoginVC"))
            .takeUntil(self.rx.deallocated) // 页面销毁自动移除通知
            .subscribe(onNext: { [weak self] (notification) in
            self?.scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
        }).disposed(by: rx.disposeBag)
        
        NotificationCenter.default
            .rx.notification(Notification.Name("LoginSucceed"))
            .takeUntil(self.rx.deallocated)
            .subscribe(onNext: { [weak self] (notification) in
            //self?.rx.pop()
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: rx.disposeBag)
        
    }
    
//    deinit {
//        print("页面销毁")//移除通知
//        NotificationCenter.default.removeObserver(self)
//    }
    
}
