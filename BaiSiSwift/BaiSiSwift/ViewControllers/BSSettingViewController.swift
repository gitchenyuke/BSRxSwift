//
//  BSSettingViewController.swift
//  BaiSiSwift
//
//  Created by chenyk on 2019/1/11.
//  Copyright © 2019 陈宇科. All rights reserved.
//

import UIKit

class BSSettingViewController: BSBaseViewController {
    
    var btnOut: UIButton!
    // 闭包
    typealias outBlock = (() -> Void)
    var block: outBlock?

    override func viewDidLoad() {
        super.viewDidLoad()

        btnOut = UIButton.init().chain
            .tintColor(.white)
            .font(BSFonts(FONT_BIG))
            .title("退出登录", for: .normal)
            .backgroundColor(UIColor.hexadecimalColor(COLOR_NAV_BAR)).build
        
        view.addSubview(btnOut)
        
        btnOut.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(60)
        }
        
        btnOut.rx.tap.subscribe(onNext: { [weak self] () in
            userManger.user.login = false
            userManger.saveToCache()
            if let block = self?.block{
                block()
            }
        }).disposed(by: rx.disposeBag)
        
        /// 返回
        btnOut.rx.tap.bind(to: rx.pop(animated: true)).disposed(by: rx.disposeBag)
    }
    
    // 闭包类似OC的block
    func getBlock(block: outBlock?){
        self.block = block
    }
}
