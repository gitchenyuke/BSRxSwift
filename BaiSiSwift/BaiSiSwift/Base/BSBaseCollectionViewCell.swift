//
//  BSBaseCollectionViewCell.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/11/29.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit

class BSBaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }
    
    /// 类方法
    class func getCellSizeWithModel(model:Any)-> CGSize {
        return .zero
    }
}
