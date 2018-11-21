//
//  MeViewController.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/15.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MeViewController: BSBaseViewController {
    
    lazy var loginBtn: UIButton = {
        UIButton.init(type: .custom).chain
            .frame(CGRect(x: 0, y: 0, width: 100, height: 40))
            .systemFont(ofSize: FONT_MIDDLE)
            .title("登陆/注册", for: .normal)
            .titleColor(UIColor.white, for: .normal)
            .center(view.center)
            .backgroundColor(UIColor.hexadecimalColor(COLOR_NAV_BAR))
            .build
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigation.item.title = "我"
        
        ViewRadius(view: loginBtn, Radius: 5)
        
        view.addSubview(loginBtn)
        
        loginBtn.rx.tap.subscribe(onNext: { [weak self] in
            let loginVC = BSLoginWithRegiestController()
            self?.navigationController?.pushViewController(loginVC, animated: true)
        }).disposed(by: rx.disposeBag)
    
    }
    
}
