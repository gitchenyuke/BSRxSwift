//
//  ObservableType+HandyJSON.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/16.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import HandyJSON

fileprivate let RESULT_CODE = "code"
fileprivate let RESULT_DATA = "data"
fileprivate let RESULT_MESSAGE = "message"


extension ObservableType where E == Response {
    public func mapModel<T: HandyJSON>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(response.mapModel(T.self))
        }
    }
}

extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) -> T {
        let jsonString = String.init(data: data, encoding: .utf8)
        return JSONDeserializer<T>.deserializeFrom(json: jsonString)!
    }
}

// 自定义扩展，这里实现一个error情况下toast弹出
extension Observable {
    
    func showErrorToast() -> Observable<Element> {
        return self.do(onNext: { response in
            
//            if let dict = response as? BaseModel {
//                if dict.code != 1{
//                    throw RxSwiftMoyaError.customError(resultCode: dict.code ?? 404, resultMsg: dict.message ?? "数据解析失败")
//                }
//            }else{
//                throw RxSwiftMoyaError.parseJSONError
//            }
            
        }, onError: { error in
            // 错误信息，弹出Toast
            throw RxSwiftMoyaError.customError(resultCode: 404, resultMsg: "无网络")
        })
    }
    
}

// 扩展一个error类型
enum RxSwiftMoyaError : Swift.Error {
    case parseJSONError
    case noRepresentor
    case notSuccessfulHTTP
    case noData
    case couldNotMakeObjectError
    case customError(resultCode: NSNumber, resultMsg: String)
}

extension RxSwiftMoyaError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .parseJSONError:
            return "数据解析失败"
        case .noRepresentor:
            return "NoRepresentor."
        case .notSuccessfulHTTP:
            return "NotSuccessfulHTTP."
        case .noData:
            return "NoData."
        case .couldNotMakeObjectError:
            return "CouldNotMakeObjectError."
        case .customError(resultCode: let resultCode, resultMsg: let resultMsg):
            return "错误码: \(resultCode), 错误信息: \(resultMsg)"
        }
    }
}
