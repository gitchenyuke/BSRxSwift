//
//  BSCommentTableViewCell.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/11/5.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import Kingfisher

class BSCommentTableViewCell: BSBaseTableViewCell {

    var ivIcon: UIImageView! // 头像
    var ivSex: UIImageView! // 性别
    var labNick: UILabel!  // 昵称
    var labtotalLike: UILabel! // 总共多少赞
    var labContext: UILabel!   // 评论内容
    var ivCover: UIImageView!  // 评论图片
    var like: ListColumnView!  //赞👍
    var dislike: ListColumnView! //踩
    
    override func setupUI() {
        super.setupUI()
        
        ivIcon = UIImageView.init()
        ivSex = UIImageView.init()
        ivCover = UIImageView.init()
        
        labNick = UILabel.text(textColor: COLOR_BLUE, textFont: FONT_SMALL)
        labtotalLike = UILabel.textColor(textColor: UIColor.white, textFont: FONT_SMALL)
        labContext = UILabel.text(textColor: COLOR_BLACK_TWO, textFont: FONT_MIDDLE)
        like = ListColumnView.init(frame: .zero)
        dislike = ListColumnView.init(frame: .zero)
        
        ViewRadius(view: labtotalLike, Radius: 3)
        labContext.numberOfLines = 0
        labtotalLike.backgroundColor = UIColor.hexadecimalColor(COLOR_ORANGE)
        labtotalLike.textAlignment = .center
        like.ivImage.image = UIImage.init(named: "iv_like")
        dislike.ivImage.image = UIImage.init(named: "iv_cai")
        ViewRadius(view: ivIcon, Radius: 20)
        
        like.layouRight()
        dislike.layouRight()
        
        contentView.addSubview(ivIcon)
        contentView.addSubview(ivSex)
        contentView.addSubview(ivCover)
        contentView.addSubview(labNick)
        contentView.addSubview(labtotalLike)
        contentView.addSubview(labContext)
        contentView.addSubview(like)
        contentView.addSubview(dislike)
        
        ivIcon.frame = CGRect(x: 15, y: 15, width: 40, height: 40)
        ivSex.frame = CGRect(x: ivIcon.frame.maxX + 10, y: ivIcon.frame.midY - 8, width: 16, height: 16)
        labNick.frame = CGRect(x: ivSex.frame.maxX + 5, y: ivSex.frame.midY - 8, width: 150, height: 16)
        labtotalLike.frame = CGRect(x: 15, y: ivIcon.frame.maxY + 10, width: 40, height: 14)
        dislike.frame = CGRect(x: kScreenWidth - 70, y: ivIcon.frame.midY - 10, width: 60, height: 20)
        like.frame = CGRect(x: dislike.frame.minX - 60, y: ivIcon.frame.midY - 10, width: 60, height: 20)
        
    }
    
    func reloadData(_ data: CommentEntity) {
        
        ivIcon.kf.setImage(with: ImageResource(downloadURL: URL.init(string: data.user?.profile_image ?? "")!), placeholder: BSPlaceholderImage())
        labtotalLike.text = data.user?.total_cmt_like_count
        labNick.text = data.user?.username
        labContext.text = data.content
        like.labCount.text = data.like_count
        dislike.labCount.text = data.hate_count
        
        if data.user?.sex == "m" {
            ivSex.image = BSImaged("iv_sex_m")
        }else {
             ivSex.image = BSImaged("iv_sex_w")
        }
        
        let contextW = kScreenWidth - ivSex.frame.maxX - 15
        
        let contextH:CGFloat = String.getNormalStrH(str: data.content ?? "", strFont: FONT_MIDDLE, w: contextW)
        labContext.frame = CGRect(x: ivIcon.frame.maxX + 10, y: ivIcon.frame.maxY + 10, width: contextW, height: contextH)
        let size = getCoverSize(data)
        ivCover.frame = CGRect(x: ivIcon.frame.maxX + 10, y: labContext.frame.maxY + size.width, width: contextW/2, height: size.height)
    }
    
    
    func getCoverSize(_ data: CommentEntity) -> CGSize {
        var coverH:CGFloat = 0
        var mager:CGFloat = 0
        
        let coverW = (kScreenWidth - ivSex.frame.maxX - 15)/2
        let imageWidt = data.image?.width ?? 0
        let imageHight = data.image?.height ?? 0
        
        if data.type == "image" {
            mager = 5
            coverH = coverW * imageHight / imageWidt
            let imageStr = data.image?.images?.first
            ivCover.kf.setImage(with: ImageResource(downloadURL: URL.init(string: imageStr ?? "")!), placeholder: BSPlaceholderImage())
        }else{
            mager = 0
            coverH = 0
        }
        return CGSize.init(width: mager, height: coverH)
    }
    
    //getCellHight
    func getContextHight(_ data: CommentEntity) -> CGFloat {
        let spacing:CGFloat = 20
        let contextH:CGFloat = String.getNormalStrH(str: data.content ?? "", strFont: FONT_MIDDLE, w: kScreenWidth - ivSex.frame.maxX - 15)
        let size = getCoverSize(data)
        return spacing + size.width + contextH + size.height + 65
    }
   
    static func getCellHightData(_ data: CommentEntity) -> CGFloat {
        return self.init().getContextHight(data)
    }

}
