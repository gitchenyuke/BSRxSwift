//
//  UserCenterManger.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/11/27.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import Cache

struct UserModel: Codable{
    var mobile: String
    var pwd:String
}

class UserCenterManger {
    var user:UserModel!
    /// 单例
    static let sharedInstance = UserCenterManger()

    private init() {
        let diskConfig = DiskConfig.init(name: "UserCache",//磁盘存储的名称，这将用作目录中的文件夹名称
            expiry: .never,//到期时间.never 无限期  .date(Date().addingTimeInterval(2*3600))
            maxSize: 10000,//磁盘缓存存储的最大大小（以字节为单位）
            //                                         directory: try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask,appropriateFor: nil, create: true).appendingPathComponent("MyPreferences"),//存储磁盘缓存的位置。如果为nil，则将其放在`cachesDirectory`目录中。
            protectionType: .complete)//数据保护用于在磁盘上存储加密格式的文件，并对其进行解密需求
        
        let dataStorage = try! Storage(
            diskConfig: diskConfig,
            memoryConfig: MemoryConfig(),
            transformer: TransformerFactory.forData()
        )

        let userStorage = dataStorage.transformCodable(ofType: UserModel.self)
        user = try? userStorage.object(forKey: "user")
    }
}

// MARK: - 缓存
extension UserCenterManger {
    func saveToCache() {
        
        let diskConfig = DiskConfig.init(name: "UserCache",//磁盘存储的名称，这将用作目录中的文件夹名称
            expiry: .never,//到期时间.never 无限期
            maxSize: 10000,
            protectionType: .complete)//数据保护用于在磁盘上存储加密格式的文件，并对其进行解密需求
        
        let dataStorage = try! Storage(
            diskConfig: diskConfig,
            memoryConfig: MemoryConfig(),
            transformer: TransformerFactory.forData()
        )

        let userStorage = dataStorage.transformCodable(ofType: UserModel.self)
        try? userStorage.setObject(user, forKey: "user")
    }
}
