//
//  ListHeaderSctionView.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/18.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import Kingfisher
import Gifu
import RxGesture

protocol HeaderSectionDelegate:class {
    func didSelectedHeader(data:JHListEntity)
}

class ListHeaderSctionView: UIView {

    // 代理
    weak var delegate: HeaderSectionDelegate?
    
    var entity:JHListEntity!
    
    var ivIcon: UIImageView!
    var labName: UILabel!
    var labTime: UILabel!
    var labContent: UILabel!
    var gifLogo: UIImageView!
    var ivCover: GIFImageView!
    var columnDZ: ListColumnView!
    var columnCai: ListColumnView!
    var columnFX: ListColumnView!
    var columnPL: ListColumnView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        /// tap
        self.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        self.addGestureRecognizer(tap)
        
//        self.rx.tapGesture().when(.recognized).subscribe(onNext: {  _ in
//            self.delegate?.didSelectedHeader(data: self.entity)
//        }).disposed(by: rx.disposeBag)
        
        ivIcon = UIImageView.init()
        labName = UILabel.text(textColor: COLOR_BLUE, textFont: FONT_MIDDLE)
        labTime = UILabel.text(textColor: COLOR_BLACK_THREE, textFont: FONT_SMALL)
        labContent = UILabel.text(textColor: COLOR_BLACK_TWO, textFont: FONT_BIG)
        ivCover = GIFImageView.init(frame: .zero)
        gifLogo = UIImageView.init(image: BSImaged("iv_gif"))
        
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
        
        self.addSubview(ivIcon)
        self.addSubview(labName)
        self.addSubview(labTime)
        self.addSubview(labContent)
        self.addSubview(ivCover)
        self.addSubview(columnDZ)
        self.addSubview(columnCai)
        self.addSubview(columnFX)
        self.addSubview(columnPL)
        ivCover.addSubview(gifLogo)
        
        ivIcon.frame  = CGRect(x: 15, y: 15, width: 40, height: 40)
        labName.frame = CGRect(x: ivIcon.frame.maxX + 5, y: ivIcon.frame.minY, width: 200, height: 16)
        labTime.frame = CGRect(x: labName.frame.minX, y: labName.frame.maxY + 5, width: 200, height: 16)
        gifLogo.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    }
    
  
    @objc func tapClick() {
        delegate?.didSelectedHeader(data: entity)
    }
    
    func reloadData(data:JHListEntity) -> Void {
        
        entity = data
        
        let imageStr:String = data.u?.header?.first ?? ""
        var coverstr:String = ""
        
        switch data.type! {
        
        case "image":
            coverstr = data.image?.big?.first ?? ""
            ivCover.isHidden = false
            break
        case "video":
            coverstr = data.video?.thumbnail?.first ?? ""
            ivCover.isHidden = false
            break
        case "gif":
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
                gifLogo.isHidden = false
            }else{
                gifLogo.isHidden = true
                ivCover.kf.setImage(with: ImageResource(downloadURL: URL.init(string: coverstr)!), placeholder: UIImage.init(named: DefaultGraph), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
        
        ivIcon.kf.setImage(with: ImageResource(downloadURL: URL.init(string: imageStr)!), placeholder: UIImage.init(named: DefaultGraph))
        
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatalError")
    }
}
