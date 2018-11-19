//
//  ListDetailHeaderView.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/11/1.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import Gifu
import Kingfisher

class ListDetailHeaderView: UIView {

    var ivCover: GIFImageView!
    var labContext: UILabel!
    var labTime: UILabel!
    var communityView: ListCommunityView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    func initUI() {
        ivCover = GIFImageView.init(frame: .zero)
        labContext = UILabel.text(textColor: COLOR_BLACK_TWO, textFont: FONT_BIG)
        labTime = UILabel.text(textColor: COLOR_BLACK_FOURTH, textFont: FONT_SMALL)
        
        ivCover.backgroundColor = UIColor.hexadecimalColor(COLOR_BOTTOM)
        labContext.numberOfLines = 0
        
        communityView = ListCommunityView.init(frame: .zero)
        
        self.addSubview(ivCover)
        self.addSubview(labContext)
        self.addSubview(labTime)
        self.addSubview(communityView)
    }
    
    func reload(data:JHListEntity) {
        
        labContext.text = data.text
        labTime.text = String.init(format: "%@赞 · %@", data.up ?? "",data.passtime ?? "")
        
        var coverstr:String = ""
        var imageH:CGFloat = 0
        
        switch data.type! {
            
        case "image":
            coverstr = data.image?.big?.first ?? ""
            let imageWidt = data.image?.width ?? 0
            let imageHight = data.image?.height ?? 0
            let scale:CGFloat = imageHight / imageWidt
            imageH = kScreenWidth * scale
            ivCover.isHidden = false
            break
        case "video":
            imageH = 200
            coverstr = data.video?.thumbnail?.first ?? ""
            ivCover.isHidden = false
            break
        case "gif":
            imageH = 200
            coverstr = data.gif?.images?.first ?? ""
            ivCover.isHidden = false
            break
        case "text":
            ivCover.isHidden = true
            break
        default:
            break
        }
        
        if coverstr.count != 0 {
            if data.type == "gif" { //gif 图片
                ivCover.animate(withGIFURL: URL.init(string: coverstr)!)
                
            }else{
                ivCover.kf.setImage(with: ImageResource(downloadURL: URL.init(string: coverstr)!), placeholder: UIImage.init(named: DefaultGraph), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
        
        let tsgEntity = data.tags?.first
        
        if tsgEntity?.image_list?.count != 0 {
            communityView.ivIcon.kf.setImage(with: ImageResource(downloadURL: URL.init(string: tsgEntity?.image_list ?? "")!), placeholder: UIImage.init(named: DefaultGraph), options: nil, progressBlock: nil, completionHandler: nil)
        }
        
        communityView.labTitle.text = tsgEntity?.name
        communityView.labSubTitle1.text = String.init(format: "社区共%@名%@|%@帖子", tsgEntity?.sub_number ?? "" ,tsgEntity?.tail ?? "" ,tsgEntity?.post_number ?? "")
        communityView.labSubTitle2.text = tsgEntity?.info
        
        let textHight = String.getNormalStrH(str: data.text ?? "", strFont: FONT_BIG, w: kScreenWidth-30)
        ivCover.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: imageH)
        labContext.frame = CGRect(x: 15, y: ivCover.frame.maxY + 15, width: kScreenWidth - 30, height: textHight)
        labTime.frame = CGRect(x: 15, y: labContext.frame.maxY + 15, width: kScreenWidth - 30, height: 15)
        communityView.frame = CGRect(x: 0, y: labTime.frame.maxY + 15, width: kScreenWidth, height: 120)
    }
    
    
    class func getHightData(data:JHListEntity) -> CGFloat {
        
        let textHight = String.getNormalStrH(str: data.text ?? "", strFont: FONT_BIG, w: kScreenWidth-30)
        
        var imageHight:CGFloat!
        
        if data.type == "text" {
            imageHight = 0
        }else if data.type == "image"{
            let imageWidt = data.image?.width ?? 0
            let imageHight1 = data.image?.height ?? 0
            let scale:CGFloat = imageHight1 / imageWidt
            imageHight = kScreenWidth * scale
        }else{
            imageHight = 200
        }
        return 15*4+120+textHight+imageHight
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
