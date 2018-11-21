//
//  BSAPI.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/16.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import SVProgressHUD


enum APIManager {
    case submenus //精华目录
    case jhrecommend(json:String) /// 精华推荐列表
    case jhimage(json:String) /// 精华图片专区列表
    case jhvideo(json:String) /// 精华视频专区列表
    case jhremen(json:String) /// 精华排行专区列表
    case jhjoke(json:String) /// 精华笑话专区列表
    case detailCommentList(id:String,page:String , json:String) /// 详情评论列表
}

extension APIManager: TargetType {
    /// 域名
    var baseURL: URL {
        switch self {
        case .submenus:
            return URL.init(string: "http://s.budejie.com")!
        case .detailCommentList:
            return URL.init(string: "http://c.api.budejie.com")!
        default:
            return URL.init(string: "http://s.budejie.com")!
        }
    }
    
    /// 请求路劲
    var path: String {
        switch self {
        case .submenus: return "public/list-appbar/bs0315-iphone-4.5.9"
        case .jhimage(let json): return "topic/list/jingxuan/10/bs0315-iphone-4.5.9/\(json)"
        case .jhvideo(let json): return "topic/list/jingxuan/41/bs0315-iphone-4.5.9/\(json)"
        case .jhremen(let json): return "topic/list/remen/1/bs0315-iphone-4.5.9/\(json)"
        case .jhjoke(let json): return "topic/tag-topic/63674/hot/bs0315-iphone-4.5.9/\(json)"
        case .jhrecommend(let json): return "topic/list/jingxuan/1/bs0315-iphone-4.5.9/\(json)"
        case .detailCommentList(let id ,let page , let json): return "topic/comment_list/\(id)/\(page)/bs0315-iphone-4.5.9/\(json)"
        }
    }
    

    /// 请求方式
    var method: Moya.Method { return .get}
    
    var task: Task {
        let parameters = ["version":Bundle.main.infoDictionary!["CFBundleShortVersionString"]!]
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
    /// 验证
    public var validate: Bool {
        return false
    }
    
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    
    /// 头文件
    var headers: [String : String]? {
        return nil
    }
}


/// loading
let LoadingPlugin = NetworkActivityPlugin { (type, target) in
    
    switch type {
    case .began:
        BSProgressHUD.showLoading("正在加载...")
    case .ended:
        BSProgressHUD.dismissHUD()
    }
}

/// 请求时间
let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<APIManager>.RequestResultClosure) -> Void in
    
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}

/// 带Loading的网络请求
let bsLoadingProvider = MoyaProvider<APIManager>(requestClosure: timeoutClosure, plugins: [LoadingPlugin])
let bsProvider = MoyaProvider<APIManager>(requestClosure: timeoutClosure)
