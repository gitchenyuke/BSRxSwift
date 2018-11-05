//
//  BSBaseTableViewCell.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/15.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit

class BSBaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
    }
    
    func setupUI() {}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatalError")
    }
    
    /// 类方法
    class func getCellHightWithModel(model:Any)-> CGFloat {
        return 0
    }

}
