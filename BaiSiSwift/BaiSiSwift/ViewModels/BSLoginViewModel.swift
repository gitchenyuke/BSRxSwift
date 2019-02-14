//
//  BSLoginViewModel.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/11/27.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BSLoginViewModel: NSObject {

}

extension BSLoginViewModel:BSViewModelType{
    
    typealias Input = BSLoginInput
    typealias Output = BSLoginOutput
    
    struct BSLoginInput {
        var mobile:Observable<String>
        var pwd:Observable<String>
        /// 点击登录事件
        var loginTips: ControlEvent<Void>
    }
    
    struct BSLoginOutput {
        var loginEnbled:Driver<Bool>
        /// 是否点击了登录(主要是监听点击后回收键盘)
        var login:Driver<Bool>
        /// 登录成功
        var loginSucceed:Driver<Bool>
        
    }
    
    func transform(input: BSLoginViewModel.BSLoginInput) -> BSLoginViewModel.BSLoginOutput {
        let loginEnbled = Observable.combineLatest(input.mobile.asObservable(),input.pwd.asObservable()) { (mobile,pwd) -> Bool in
            
            if !mobile.isEmpty && !pwd.isEmpty{
                return true
            }
            return false
        }.asDriver(onErrorJustReturn: false)
        
        let mobileAndPwd = Observable.combineLatest(input.mobile.asObservable(),input.pwd.asObservable()){ ($0,$1) }
        
        let login = input.loginTips.asObservable().map { () -> Bool in
            return true
        }.asDriver(onErrorJustReturn: false)
        
        ///withLatestFrom将两个可观察序列组合为一个可观察序列 flatMapLatestflatMapLatest 操作符将源 Observable 的每一个元素应用一个转换方法，将他们转换成 Observables
        let loginSucceed = input.loginTips.withLatestFrom(mobileAndPwd).flatMapLatest { (mobil,pwd) -> Driver<Bool> in
            let userManger = UserCenterManger.sharedInstance
            
            /// 如果不符合则return 就用guard
            guard userManger.user != nil else{
                BSProgressHUD.showError("账号不存在")
                return Driver.just(false)
            }
            
            if mobil == userManger.user.mobile && pwd == userManger.user.pwd {
                BSProgressHUD.showSuccess("登录成功")
                userManger.user.login = true
                userManger.saveToCache()
                return Driver.just(true)
            }else{
                BSProgressHUD.showError("手机或密码错误")
                return Driver.just(false)
            }
        }.asDriver(onErrorJustReturn: false)
        
        /// 输出
        return BSLoginOutput.init(loginEnbled: loginEnbled, login: login, loginSucceed: loginSucceed)
    }
}
