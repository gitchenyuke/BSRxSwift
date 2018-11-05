//
//  BSEntity.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/16.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import Foundation
import HandyJSON
import RxCocoa
import RxSwift
import RxDataSources

/// 精华目录
struct EssenceMenusListEntity: HandyJSON {
    var menus:[EssenceMenusEntity]?
}

struct EssenceMenusEntity: HandyJSON {
    var name:String?
    var submenus:[EssenceSubmenusEntity]?
}

struct EssenceSubmenusEntity: HandyJSON {
    var name:String?
    var type:String?
    var display_num:String?
    var entrytype:String?
}

struct Info: HandyJSON {
    var count:String?
    var np:String? //上拉加载需要拼接的随机数据
}

/// 精华推荐列表
struct JHRecommendListEntity: HandyJSON{
    var info: Info?
    var list:[JHListEntity]?
}

struct JHListEntity: HandyJSON {
    var status:String?
    var cate:String?
    var name:String?
    var top_comments:[Top_commentsEntity]?
    var bookmark:String? //阅读数
    var text:String?
    var video:VideoEntity?
    var u:UEntity?
    var passtime:String?
    var type:String? //类型: text image video gif
    var id:String?
    var image:ImageEntity?
    var gif:GifEntity?
    var comment:String? //评论
    var up:String? //点赞
    var down:String? //踩
    var forward:String? //分享
    var tags:[tagsEntity]? //社区类型
}

/// 个人信息
struct UEntity: HandyJSON {
    var header: [String]? //头像
    var uid:String? // uid
    var is_vip:Bool? // 是否会员
    var sex:String? //性别
    var name:String? //昵称
}

/// 置顶的评论
struct Top_commentsEntity: HandyJSON {
    var u: UEntity? // 个人信息
    var id: String?  //id
    var content:String? // 评论内容
    var passtime: String? //更新时间
    var like_count: String? //点赞人数
}

/// 视频
struct VideoEntity: HandyJSON {
    var video: [String]?
    var thumbnail: [String]? // 封面图
    var width: CGFloat?
    var height: CGFloat?
}

/// 图片
struct ImageEntity: HandyJSON {
    var big: [String]? // 封面图
    var width: CGFloat?
    var height: CGFloat?
}

/// 动态图
struct GifEntity: HandyJSON {
    var images: [String]?
    var gif_thumbnail: [String]? //封面图
    var width: CGFloat?
    var height: CGFloat?
}

/// 社区
struct tagsEntity: HandyJSON {
    var post_number: String?  // 帖子数量
    var sub_number: String?  // 发帖用户数量
    var name: String?
    var info: String?
    var id: String?
    var image_list: String?  //icon
    var tail: String? //有故事的人
}

struct CommentListEntity:HandyJSON{
    var normal:NormalCommentEntity?
}

struct NormalCommentEntity: HandyJSON{
    var list: [CommentEntity]?
}

/// 评论内容
struct CommentEntity:HandyJSON{
    var ctime: String!  // 评论时间
    var data_id: String?  // id
    var content: String?  // 评论内容
    var like_count: String?  // 点赞数
    var hate_count: String? // 踩
    var type: String?  //类型: text image video gif
    var user: CommentUserEntity?  // 用户信息
    var image: CommentImageEntity?
}

/// 评论用户信息
struct CommentUserEntity:HandyJSON{
    var username: String!  // 昵称
    var profile_image: String!  // 头像id
    var total_cmt_like_count: String!  // 点赞总数量
    var sex: String!  // 性别 "m"男
    var id: String!  // id
}

/// 评论图片
struct CommentImageEntity: HandyJSON {
    var images: [String]?
    var width: CGFloat?
    var height: CGFloat?
}



// MARK - RxDataSources
struct JHListEntitySection {
    var items: [Item]
}

/// 评论内容
struct DetailCommentSection {
    var items: [Item]
}

extension DetailCommentSection:SectionModelType {
    typealias Item = CommentEntity
    init(original: DetailCommentSection, items: [Item]) {
        self = original
        self.items = items
    }
}


/// 遵守 RxDataSources 协议
extension JHListEntitySection:SectionModelType {
    typealias Item = JHListEntity
    init(original: JHListEntitySection, items: [Item]) {
        self = original
        self.items = items
    }
}


struct GroupedJHSection {
    var header: JHListEntity?
    var items: [Item]
}

extension GroupedJHSection: SectionModelType {
    typealias Item = Top_commentsEntity
    
    init(original: GroupedJHSection, items: [Top_commentsEntity]) {
        self = original
        self.items = items
    }
}
