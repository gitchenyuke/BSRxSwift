//
//  BSListViewModel.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/16.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import RxSwift

class BSListViewModel {

    /// 数据
    let datas = Variable<[JHListEntitySection]>([])
    
    /// 结束刷新
    let refreshEnd = PublishSubject<Void>()
    
    let disposeBag = DisposeBag.init()
    /// 上拉在加载时拼接的path
    var json:String!
    
    
    init() {}
    
    func reload(type:String , json:String) {
        
        let api = String.jhRequest(type: type,json: json)
        
        bsLoadingProvider
            .rx.request(api)
            .asObservable().mapModel(JHRecommendListEntity.self)
            .showErrorToast()
            .subscribe(onNext: { [weak self] (model) in
            
            let section = [JHListEntitySection(items: model.list ?? [])]
            let jsonprefix:String = model.info?.np ?? ""
            let jsonStr = String.init(format: "%@-20.json", jsonprefix)
            self?.json = jsonStr
            
            if json == "0-20.json" {
                self?.datas.value = section
            }else{
                self?.datas.value += section
            }
            /// 结束刷新
            self?.refreshEnd.onNext(())
        }, onError: { [weak self] (error) in
            /// 结束刷新
            self?.refreshEnd.onNext(())
            BSProgressHUD.showError(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
}
