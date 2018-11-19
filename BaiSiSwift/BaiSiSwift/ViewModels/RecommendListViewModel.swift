//
//  RecommendListViewModel.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/19.
//  Copyright © 2018 陈宇科. All rights reserved.
//er

import UIKit
import RxSwift

class RecommendListViewModel: NSObject {
    /// 数据
    let data = Variable<[GroupedJHSection]>([])
    
    /// 结束刷新
    let refreshEnd = PublishSubject<Void>()
    
    /// 上拉在加载时拼接的path
    var json:String!
    
    override init() {
        super.init()
    }
    
    func reload(type:String , json:String) {
        
        let api = String.jhRequest(type: type,json: json)
        
        bsLoadingProvider
            .rx.request(api)
            .asObservable().mapModel(JHRecommendListEntity.self)
            .showErrorToast()
            .subscribe(onNext: { [weak self] (model) in
                
                let jsonprefix:String = model.info?.np ?? ""
                let jsonStr = String.init(format: "%@-20.json", jsonprefix)
                self?.json = jsonStr
                
                let arr:[JHListEntity] = model.list ?? []
                var seconArr:[GroupedJHSection] = []
                
                for entity in arr {
                    let con:[Top_commentsEntity] = entity.top_comments ?? []
                    seconArr.append(GroupedJHSection(header: entity, items: con))
                }
                
                if json == "0-20.json" {
                    self?.data.value = seconArr
                }else{
                    self?.data.value += seconArr
                }
            
                /// 结束刷新
                self?.refreshEnd.onNext(())
                }, onError: { [weak self] (error) in
                    /// 结束刷新
                    self?.refreshEnd.onNext(())
                    BSProgressHUD.showError(error.localizedDescription)
            }).disposed(by: rx.disposeBag)
    }
}
