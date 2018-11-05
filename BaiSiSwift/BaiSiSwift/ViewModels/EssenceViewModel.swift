//
//  EssenceViewModel.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/16.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class EssenceViewModel: NSObject {

    let datas = Variable<[EssenceSubmenusEntity]>([])
    
    override init() {
        super.init()
        self.reload()
    }
}

extension EssenceViewModel {
    
    /// 请求数据
    func reload() {
        
        bsLoadingProvider
            .rx.request(.submenus)
            .asObservable()
            .mapModel(EssenceMenusListEntity.self)
            .showErrorToast()
            .subscribe(onNext: { [weak self] (model) in
                
            guard let `self` = self else { return }
            let menus = model.menus?.first
            self.datas.value = menus?.submenus ?? []
        }, onError: { (error) in
            BSProgressHUD.showError(error.localizedDescription)
        }).disposed(by: rx.disposeBag)
    }
}
