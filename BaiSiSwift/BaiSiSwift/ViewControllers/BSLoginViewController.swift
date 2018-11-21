//
//  BSLoginViewController.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/11/20.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit


class BSLoginViewController: UIViewController {
    
    var bgView: UIView!
    var mobiletf: UITextField!
    var ivLine: UIImageView!
    var passWordtf: UITextField!
    var loginButton: UIButton!
    var forgetpswLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgView = UIView.init(frame: CGRect(x: 20, y: 100, width: kScreenWidth-40, height: 120))
        ViewRadius(view: bgView, Radius: 5)
        
        mobiletf = UITextField.init(frame: CGRect(x: 10, y: 0, width: kScreenWidth-30, height: 60)).chain
            .textColor(UIColor.white).placeholder("手机号")
            .font(BSFonts(FONT_MIDDLE)).build
        
        ivLine = UIImageView.init(frame: CGRect(x: 0, y: 60, width: kScreenWidth-40, height: 0.5))
            .chain.backgroundColor(UIColor.hexadecimalColor(COLOR_LINE)).build
        
        passWordtf = UITextField.init(frame: CGRect(x: 10, y: 60, width: kScreenWidth-30, height: 60)).chain
            .textColor(UIColor.white).placeholder("密码")
            .font(BSFonts(FONT_MIDDLE)).build
        
        let disabledImage = imageFromColor(UIColor.hexadecimalColor(COLOR_LINE), CGSize.init(width: kScreenWidth - 40, height: 50))
        let normalImage = imageFromColor(UIColor.hexadecimalColor(COLOR_NAV_BAR), CGSize.init(width: kScreenWidth - 40, height: 50))
        
        loginButton = UIButton.init(type: .custom).chain
            .titleColor(UIColor.white, for: .normal)
            .title("登录", for: .normal)
            .backgroundImage(normalImage, for: .normal)
            .backgroundImage(disabledImage, for: .disabled)
            .frame(CGRect(x: 20, y: bgView.frame.maxY + 15, width: kScreenWidth-40, height: 50))
            .font(BSFonts(FONT_MIDDLE)).build

        forgetpswLabel = UILabel
            .init(frame: CGRect(x: loginButton.frame.maxX - 100, y: loginButton.frame.maxY + 10, width: 100, height: 20))
            .chain.font(BSFonts(FONT_MIDDLE))
            .textAlignment(.right)
            .textColor(UIColor.white)
            .text("忘记密码？").build
        
        ViewBorderRadius(view: bgView, Radius: 5, Width: 0.5, Color: UIColor.hexadecimalColor(COLOR_LINE))
        ViewRadius(view: loginButton, Radius: 5)
        
        view.addSubview(bgView)
        view.addSubview(loginButton)
        view.addSubview(forgetpswLabel)
        bgView.addSubview(mobiletf)
        bgView.addSubview(ivLine)
        bgView.addSubview(passWordtf)
    }

}
