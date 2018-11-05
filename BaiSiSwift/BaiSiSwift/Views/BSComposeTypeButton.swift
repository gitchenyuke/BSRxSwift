//
//  BSComposeTypeButton.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/23.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit

class BSComposeTypeButton: UIView {

    var imagev : UIImageView!
    var title : UILabel!
    
  
    class func initTypeButton(imageName:String,title:String) -> BSComposeTypeButton {
        let button = BSComposeTypeButton.init(frame: .zero)
        button.imagev.image = UIImage.init(named: imageName)
        button.title.text = title
        return button
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imagev = UIImageView.init()
        title = UILabel.text(textColor: COLOR_BLUE, textFont: FONT_MIDDLE)
        title.textAlignment = .center
        
        self.addSubview(imagev)
        self.addSubview(title)
    }
    
    override func layoutSubviews() {
        imagev.snp.makeConstraints { (make) in
            make.top.centerX.equalTo(self)
            make.size.equalTo(CGSize.init(width: 70, height: 70))
        }
        
        title.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
