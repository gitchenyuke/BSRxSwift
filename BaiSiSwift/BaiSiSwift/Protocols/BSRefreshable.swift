//
//  BSRefreshable.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/22.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx
import MJRefresh

enum BSRefreshStatus {
    case none
    case beingHeaderRefresh
    case endHeaderRefresh
    case beingFooterRefresh
    case endFooterRefresh
    case noMoreData
}

protocol OutputRefreshProtocal {
    var refreshStatus: BehaviorRelay<BSRefreshStatus> { get }
}

extension OutputRefreshProtocal {
    func autoSetRefreshHeaderStatus(header:MJRefreshHeader?,footer:MJRefreshFooter?) -> Disposable {
        return refreshStatus.asObservable().subscribe(onNext: { (status) in
            switch status {
            case .beingHeaderRefresh:
                header?.beginRefreshing()
            case .endHeaderRefresh:
                header?.endRefreshing()
            case .beingFooterRefresh:
                footer?.beginRefreshing()
            case .endFooterRefresh:
                footer?.endRefreshing()
            default:
                break
            }
        })
    }
}

/// 刷新协议
protocol BSRefreshable {
    
}

extension BSRefreshable where Self : UIViewController {
    
    /// 自定义MJRefreshHeader
    func initRefreshGifHeader(_ scrollView:UIScrollView,action: @escaping () -> Void) -> MJRefreshHeader {
        let header = BSRefreshGifHeader.init(refreshingBlock: { action() })
        scrollView.mj_header = header
        return scrollView.mj_header
    }
    
    /// 默认
    func initRefreshHeader(_ scrollView: UIScrollView, _ action: @escaping () -> Void) -> MJRefreshHeader {
        scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { action() })
        return scrollView.mj_header
    }
    
    func initRefreshFooter(_ scrollView: UIScrollView, _ action: @escaping () -> Void) -> MJRefreshFooter {
        scrollView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { action() })
        return scrollView.mj_footer
    }
}
