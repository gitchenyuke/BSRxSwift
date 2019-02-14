//
//  ListTableViewCell.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/16.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ListTableViewCell: BSBaseTableViewCell {

    var ivIcon: UIImageView!
    var labName: UILabel!
    var labTime: UILabel!
    var labContent: UILabel!
    var ivCover: UIImageView!
    var columnDZ: ListColumnView!
    var columnCai: ListColumnView!
    var columnFX: ListColumnView!
    var columnPL: ListColumnView!
    
    override func setupUI() {
        
        ivIcon = UIImageView.init()
        labName = UILabel.text(textColor: COLOR_BLUE, textFont: FONT_MIDDLE)
        labTime = UILabel.text(textColor: COLOR_BLACK_THREE, textFont: FONT_SMALL)
        labContent = UILabel.text(textColor: COLOR_BLACK_TWO, textFont: FONT_BIG)
        ivCover = UIImageView.init()
        
        columnDZ = ListColumnView.init(frame: CGRect.zero)
        columnCai = ListColumnView.init(frame: CGRect.zero)
        columnFX = ListColumnView.init(frame: CGRect.zero)
        columnPL = ListColumnView.init(frame: CGRect.zero)
        
        columnDZ.layouLeft()
        columnCai.layouMid()
        columnFX.layouMid()
        columnPL.layouRight()
        
        columnDZ.ivImage.image = UIImage.init(named: "iv_like")
        columnFX.ivImage.image = UIImage.init(named: "iv_fx")
        columnCai.ivImage.image = UIImage.init(named: "iv_cai")
        columnPL.ivImage.image = UIImage.init(named: "iv_comment")
        
        ivCover.backgroundColor = UIColor.hexadecimalColor(COLOR_BOTTOM_TWO)
        labContent.numberOfLines = 0
        
        ViewRadius(view: ivIcon, Radius: 20)
        
        ivCover.contentMode = .scaleAspectFill
        ivCover.clipsToBounds = true
        
        contentView.addSubview(ivIcon)
        contentView.addSubview(labName)
        contentView.addSubview(labTime)
        contentView.addSubview(labContent)
        contentView.addSubview(ivCover)
        contentView.addSubview(columnDZ)
        contentView.addSubview(columnCai)
        contentView.addSubview(columnFX)
        contentView.addSubview(columnPL)
        
        ivIcon.frame = CGRect(x: 15, y: 15, width: 40, height: 40)
        labName.frame = CGRect(x: ivIcon.frame.maxX + 5, y: ivIcon.frame.minY, width: 200, height: 16)
        labTime.frame = CGRect(x: labName.frame.minX, y: labName.frame.maxY + 5, width: 200, height: 16)
    }
    
    func reloadData(data:JHListEntity) -> Void {
        
        let imageStr:String = data.u?.header?.first ?? ""
        var coverstr:String = ""
        
        if data.type == "image" {
            coverstr = data.image?.big?.first ?? ""
            
        }
        if data.type == "video" {
            coverstr = data.video?.thumbnail?.first ?? ""
            
        }
        if data.type == "gif"   {
            coverstr = data.gif?.gif_thumbnail?.first ?? ""
        }
        
        if data.type == "text"   {
            ivCover.isHidden = true
        }else{
            ivCover.isHidden = false
            
            if coverstr.count != 0 {
                ivCover.kf.setImage(with: ImageResource(downloadURL: URL.init(string: coverstr)!), placeholder: UIImage.init(named: DefaultGraph), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
        
        ivIcon.kf.setImage(with: ImageResource(downloadURL: URL.init(string: imageStr)!), placeholder: UIImage.init(named: DefaultGraph), options: nil, progressBlock: nil, completionHandler: nil)
        
        let textHight = String.getNormalStrH(str: data.text ?? "", strFont: FONT_BIG, w: kScreenWidth-30)
        labContent.frame = CGRect(x: 15, y: ivIcon.frame.maxY + 15, width: kScreenWidth - 30, height: textHight)
        ivCover.frame = CGRect(x: 15, y: labContent.frame.maxY + 10, width: kScreenWidth - 30, height: 200)
        
        let columnW = (kScreenWidth - 30)/4
        
        if data.type == "text" {
            columnDZ.frame = CGRect(x: 15, y: labContent.frame.maxY + 10, width: columnW, height: 20)
        }else{
            columnDZ.frame = CGRect(x: 15, y: ivCover.frame.maxY + 10, width: columnW, height: 20)
        }
        
        columnCai.frame = CGRect(x: columnDZ.frame.maxX, y: columnDZ.frame.minY, width: columnW, height: 20)
        columnFX.frame = CGRect(x: columnCai.frame.maxX, y: columnDZ.frame.minY, width: columnW, height: 20)
        columnPL.frame = CGRect(x: columnFX.frame.maxX, y: columnDZ.frame.minY, width: columnW, height: 20)

        labName.text = data.u?.name
        labTime.text = data.passtime
        labContent.text = data.text
        
        columnDZ.labCount.text = data.up
        columnCai.labCount.text = data.down
        columnFX.labCount.text = data.forward
        columnPL.labCount.text = data.comment
    }
    
   
    class func getCellHightData(data:JHListEntity) -> CGFloat {
       
        let textHight = String.getNormalStrH(str: data.text ?? "", strFont: FONT_BIG, w: kScreenWidth-30)
        
        var imageHight:CGFloat!
        
        if data.type == "text" {
            imageHight = -10
        }else{
            imageHight = 200
        }
        return 15+40+15+10+15+textHight+imageHight+10+20
    }
}
