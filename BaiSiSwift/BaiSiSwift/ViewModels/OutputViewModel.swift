//
//  OutputViewModel.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/22.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx
import RxDataSources

class OutputViewModel: NSObject {
    let vmDatas = Variable<[JHListEntity]>([])
    /// 上拉在加载时拼接的path
    var json:String!
}

extension OutputViewModel: BSViewModelType {
    
    /// 输入
    typealias Input = BSListInput
    /// 输出
    typealias Output = BSListOuput
    
    struct BSListInput {
        
    }
    
    struct BSListOuput: OutputRefreshProtocal {
        /// 刷新状态
        var refreshStatus: BehaviorRelay<BSRefreshStatus>
        
        /// 刷新命令
        let requestCommand = PublishSubject<String>.init()
        
        /// 配置RxDataSources协议
        let sections: Driver<[JHListEntitySection]>
        
        init(sections:Driver<[JHListEntitySection]>) {
            self.sections = sections
            refreshStatus = BehaviorRelay<BSRefreshStatus>.init(value: .none)
        }
    }
    
    func transform(input: OutputViewModel.BSListInput) -> OutputViewModel.BSListOuput {
        
        /// 订阅vmData map转成 [JHListEntitySection]
        let temp_sections = vmDatas.asObservable().map { (sections) -> [JHListEntitySection] in
            return [JHListEntitySection.init(items: sections)]
        }.asDriver(onErrorJustReturn: [])
        
        let output = BSListOuput.init(sections: temp_sections)
        
        output.requestCommand.subscribe(onNext: { (json) in
            /// 网络请求
            bsLoadingProvider
                .rx.request(.jhrecommend(json: json))
                .asObservable()
                .mapModel(JHRecommendListEntity.self)
                .subscribe(onNext: {[weak self] (data) in
                    
                    let jsonprefix:String = data.info?.np ?? ""
                    let jsonStr = String.init(format: "%@-20.json", jsonprefix)
                    self?.json = jsonStr
                    
                    if json == "0-20.json" {
                        self?.vmDatas.value = data.list ?? []
                    }else{
                        self?.vmDatas.value += data.list ?? []
                    }
                    /// 结束刷新
                    output.refreshStatus.accept(.endHeaderRefresh)
                    output.refreshStatus.accept(.endFooterRefresh)
                }, onError: { (error) in
                    /// 网络错误显示
                    BSProgressHUD.showError(error.localizedDescription)
                    /// 结束刷新
                    output.refreshStatus.accept(.endHeaderRefresh)
                    output.refreshStatus.accept(.endFooterRefresh)
            }).disposed(by: self.rx.disposeBag)
            
        }).disposed(by: rx.disposeBag)
        
        return output
        
    }
    
}
