//
//  MeCollectionReusableView.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/11/28.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import RxSwift

class MeCollectionReusableView: UICollectionReusableView {
    
    var ivICon: UIImageView!
    var btn: UIButton!
    var bottomView: UIView!
    var btnName: UIButton!
    
    var disposeBag = DisposeBag.init()
    
    /// 单元格重用时调用
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        ivICon = UIImageView.init(frame: .zero).chain
            .image(BSImaged("icon-user-img"))
            .build
        
        btn = UIButton.init(type: .custom).chain
            .font(BSFonts(FONT_BIG))
            .titleColor(UIColor.hexadecimalColor(COLOR_BLACK_TWO), for: .normal)
            .title("登陆/注册", for: .normal).build
        
        btnName = UIButton.init(type: .custom).chain
            .font(BSFonts(FONT_BIG))
            .titleColor(UIColor.hexadecimalColor(COLOR_BLACK_TWO), for: .normal)
            .title("我胡三汉又回来啦", for: .normal).build
        
        bottomView = UIView.init().chain
            .backgroundColor(BSColors(COLOR_BOTTOM)).build
        
        ViewRadius(view: ivICon, Radius: 30)
        
        setLoginData()
        
        self.addSubview(ivICon)
        self.addSubview(btnName)
        self.addSubview(btn)
        self.addSubview(bottomView)
        
        ivICon.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(15)
            make.size.equalTo(CGSize.init(width: 60, height: 60))
        }
        
        btnName.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(ivICon.snp.right).offset(10)
        }
        
        btn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(ivICon.snp.right).offset(10)
            make.size.equalTo(CGSize.init(width: 80, height: 30))
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(self)
            make.height.equalTo(10)
        }
    }
    
    /// 设置数据
    func setLoginData() {
        
        if userManger.isLogin() {
            self.btnName.isHidden = false
            self.btn.isHidden = true
            self.ivICon.image = BSImaged("defualicon")
        }else{
            self.btnName.isHidden = true
            self.btn.isHidden = false
            self.ivICon.image = BSImaged("icon-user-img")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }
}
