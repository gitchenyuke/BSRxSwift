//
//  ListDetailViewModel.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/11/2.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ListDetailViewModel: NSObject {
    /// Variable以后计划被废弃 用BehaviorRelay代替
    let vmDatas = BehaviorRelay<[CommentEntity]>.init(value: [])
    var json:String!
    var id:String!
    var jsonNun:Int!
    var page:String!
}

extension ListDetailViewModel: BSViewModelType{
    
    /// 重新定义输入输出
    typealias Input = ListDetailInput
    typealias Output = ListDetailOuput
    struct ListDetailInput {}
    
    /// 刷新协议
    struct ListDetailOuput: OutputRefreshProtocal {
        /// 刷新状态设为可观察
        var refreshStatus: BehaviorRelay<BSRefreshStatus>
        /// 刷新命令
        let requestCommand = PublishSubject<Bool>.init()
        /// 配置RxDataSources协议
        let sections: Driver<[DetailCommentSection]>
        
        init(sections:Driver<[DetailCommentSection]>) {
            self.sections = sections
            /// 初始化
            refreshStatus = BehaviorRelay<BSRefreshStatus>.init(value: .none)
        }
        
    }
    
    func transform(input: ListDetailViewModel.ListDetailInput) -> ListDetailViewModel.ListDetailOuput {
        let temp_section = vmDatas.asObservable().map { (sections) -> [DetailCommentSection] in
            return [DetailCommentSection.init(items: sections)]
        }.asDriver(onErrorJustReturn: [])
        
        let output = ListDetailOuput.init(sections: temp_section)
        
        output.requestCommand.subscribe(onNext: { (ispull) in
            bsLoadingProvider
                .rx.request(.detailCommentList(id: self.id, page: self.page, json: self.json))
                .asObservable()
                .mapModel(CommentListEntity.self)
                .subscribe(onNext: { [weak self] (data) in
                    
                    if ispull {
                        
                        self?.page = "2"
                        self?.jsonNun += 20
                        self?.json = String.init(format: "%d-20.json", self?.jsonNun ?? 0)
                        let datas = data.normal?.list ?? []
                        let values = self?.vmDatas.value ?? []
                        self?.vmDatas.accept(values + datas)
                    }else{
                        
                        self?.page = "2"
                        self?.json = String.init(format: "20-20.json", self?.jsonNun ?? 0)
                        self?.vmDatas.accept(data.normal?.list ?? [])
                    }
                    
                    output.refreshStatus.accept(.endHeaderRefresh)
                    output.refreshStatus.accept(.endFooterRefresh)
           
                    }, onError: { (error) in
                        /// 显示错误信息
                        BSProgressHUD.showError(error.localizedDescription)
                        /// 结束刷新
                        output.refreshStatus.accept(.endHeaderRefresh)
                        output.refreshStatus.accept(.endFooterRefresh)
                }).disposed(by: self.rx.disposeBag)
        
        }).disposed(by: rx.disposeBag)
        
        return output
    }
}
