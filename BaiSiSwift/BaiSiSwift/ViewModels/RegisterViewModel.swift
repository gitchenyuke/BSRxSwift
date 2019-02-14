//
//  RegisterViewModel.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/11/21.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RegisterViewModel: NSObject {

}

extension RegisterViewModel: BSViewModelType {
    /// 输入
    typealias Input = RegisterInput
    /// 输出
    typealias Output = RegisterOuput
    
    struct RegisterInput {
        /// 手机号
        let mobile: Observable<String>
        /// 密码
        let password:Observable<String>
        /// 注册
        let registerTap: ControlEvent<Void>
    }
    
    struct RegisterOuput {
        /// 注册按钮是否可以点击 跟UI挂钩最好用Driver
        let registerEnbled:Driver<Bool>
        /// 点击注册是否 隐藏键盘
        let register: Driver<Bool>
        /// 注册成功返回登陆页面
        let registerSuccess: Driver<Bool>
    }
    
    func transform(input: RegisterViewModel.RegisterInput) -> RegisterViewModel.RegisterOuput {
        let registerEnbled = Observable.combineLatest(input.mobile.asObservable(),input.password.asObservable()){ (mobile,passwd) -> Bool in
            return mobile.count >= 11 && passwd.count >= 8
        }.asDriver(onErrorJustReturn: false)
        
        let mobileAndPwd = Observable.combineLatest(input.mobile.asObservable(),input.password.asObservable()) { ($0,$1) }
        
        /// withLatestFrom 操作符将两个 Observables 中最新的元素通过一个函数组合起来，然后将这个组合的结果发出来。当第一个 Observable 发出一个元素时，就立即取出第二个 Observable 中最新的元素，通过一个组合函数将两个最新的元素合并后发送出去
        /// flatMapLatest 操作符将源 Observable 的每一个元素应用一个转换方法，将他们转换成 Observables。一旦转换出一个新的 Observable，就只发出它的元素，旧的 Observables 的元素将被忽略掉
        /// 主要是把withLatestFrom产生的新元素转换成 Observables
        let register = input.registerTap.withLatestFrom(mobileAndPwd).flatMapLatest { (moble,pwd) -> Driver<Bool> in
            if moble.count != 11 {
                BSProgressHUD.showError("手机号码不正确")
            }
            if pwd.count < 8 {
                BSProgressHUD.showError("密码不能少于8位数")
            }
            return Driver.just(true)
        }.asDriver(onErrorJustReturn: false)
        
        let registerSuccess = input.registerTap.withLatestFrom(mobileAndPwd).flatMapLatest { (moble,pwd) -> Driver<Bool> in
            if moble.count == 11 && pwd.count >= 8 {
                BSProgressHUD.showSuccess("注册成功")
                let userManger = UserCenterManger.sharedInstance
                let user = UserModel.init(mobile: moble, pwd: pwd,login:false)
                userManger.user = user
                userManger.saveToCache()
                return Driver.just(true)
            }else{
                return Driver.just(false)
            }
        }.asDriver(onErrorJustReturn: false)
        
        return RegisterOuput.init(registerEnbled: registerEnbled, register: register , registerSuccess: registerSuccess)
    }
}
