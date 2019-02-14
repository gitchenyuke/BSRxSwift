//
//  BSRegiestViewController.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/11/20.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BSRegiestViewController: UIViewController {

    var bgView: UIView!
    var mobiletf: UITextField!
    var ivLine: UIImageView!
    var passWordtf: UITextField!
    var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        bindViewModel()
    }
    
    /// MARK: - UI
    func initUI() {
        
        bgView = UIView.init(frame: CGRect(x: 20, y: 100, width: kScreenWidth-40, height: 120))
        ViewRadius(view: bgView, Radius: 5)
        
        mobiletf = UITextField.init(frame: CGRect(x: 10, y: 0, width: kScreenWidth-30, height: 60)).chain
            .textColor(UIColor.white).placeholder("请输入手机号")
            .font(BSFonts(FONT_MIDDLE)).keyboardType(.numberPad).build
        
        ivLine = UIImageView.init(frame: CGRect(x: 0, y: 60, width: kScreenWidth-40, height: 0.5))
            .chain.backgroundColor(UIColor.hexadecimalColor(COLOR_LINE)).build
        
        passWordtf = UITextField.init(frame: CGRect(x: 10, y: 60, width: kScreenWidth-30, height: 60)).chain
            .textColor(UIColor.white).placeholder("包含大小写字母数组,长度不小于8位")
            .font(BSFonts(FONT_MIDDLE)).keyboardType(.default).build
        
        let disabledImage = imageFromColor(UIColor.hexadecimalColor(COLOR_LINE), CGSize.init(width: kScreenWidth - 40, height: 50))
        let normalImage = imageFromColor(UIColor.hexadecimalColor(COLOR_NAV_BAR), CGSize.init(width: kScreenWidth - 40, height: 50))
        
        registerButton = UIButton.init(type: .custom).chain
            .titleColor(UIColor.white, for: .normal)
            .title("注册", for: .normal)
            .backgroundImage(normalImage, for: .normal)
            .backgroundImage(disabledImage, for: .disabled)
            .frame(CGRect(x: 20, y: bgView.frame.maxY + 15, width: kScreenWidth-40, height: 50))
            .font(BSFonts(FONT_MIDDLE)).build
        
        ViewBorderRadius(view: bgView, Radius: 5, Width: 0.5, Color: UIColor.hexadecimalColor(COLOR_LINE))
        ViewRadius(view: registerButton, Radius: 5)
        
        view.addSubview(bgView)
        view.addSubview(registerButton)
        bgView.addSubview(mobiletf)
        bgView.addSubview(ivLine)
        bgView.addSubview(passWordtf)
        
    }
    
    // MARK: - bindViewModel
    func bindViewModel() {
        
        let viewModel = RegisterViewModel.init()
        
        let input = RegisterViewModel.Input.init(mobile: mobiletf.rx.text.orEmpty.shareOnce(),
                                                 password: passWordtf.rx.text.orEmpty.shareOnce(),
                                                 registerTap: registerButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        /// registerButton点击事件绑定是否可以点击属性
        output.registerEnbled
            .drive(registerButton.rx.isEnabled)
            .disposed(by: rx.disposeBag)
        
        output.register
            .drive(view.rx.endEditing)
            .disposed(by: rx.disposeBag)
        
        output.registerSuccess
            .drive(NotificationCenter.default.rx.postNotification)
            .disposed(by: rx.disposeBag)
    }

}
