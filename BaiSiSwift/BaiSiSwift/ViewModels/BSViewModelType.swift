//
//  BSViewModelType.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/22.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import Foundation

/// 输入输出流
protocol BSViewModelType {
    associatedtype Input //输入
    associatedtype Output //输出
    func transform(input: Input) -> Output
}
