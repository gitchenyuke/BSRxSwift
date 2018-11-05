//
//  BSRefreshGifHeader.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/22.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import MJRefresh

class BSRefreshGifHeader: MJRefreshGifHeader {

    /// 重写初始化
    override func prepare() {
        super.prepare()
        
        /// 闲置时图片数组
        let normalImages = [UIImage(named: "pullToRefresh_0") as Any]
        
        /// 刷新图片数组
        let refreshImages = [UIImage(named: "pullToRefresh_0")!,
                      UIImage(named: "pullToRefresh_1")!,
                      UIImage(named: "pullToRefresh_2")!,
                      UIImage(named: "pullToRefresh_3")!,
                      UIImage(named: "pullToRefresh_4")!,
                      UIImage(named: "pullToRefresh_5")!,
                      UIImage(named: "pullToRefresh_6")!,
                      UIImage(named: "pullToRefresh_6")!,
                      UIImage(named: "pullToRefresh_7")!,
                      UIImage(named: "pullToRefresh_8")!,
                      UIImage(named: "pullToRefresh_9") as Any]
        
        
        self.setTitle("生活如此艰难，还好有百思不得姐", for: .pulling)
        self.setImages(normalImages, for: .idle)
        self.setImages(refreshImages, for: .pulling)
        self.lastUpdatedTimeLabel.isHidden = true
        self.stateLabel.isHidden = false
    }

    /// 重写布局
    override func placeSubviews() {
        super.placeSubviews()
        
        // 临时方案，改动最小，不破坏第三方库
        self.stateLabel.isHidden = false
        self.lastUpdatedTimeLabel.isHidden = true
        self.gifView.contentMode = .center
        self.mj_h = 80
        self.gifView.mj_w = self.mj_w
        
        self.gifView.mj_origin.y = self.frame.origin.y + 80.0
        self.gifView.mj_size.height = self.mj_h - 60.0
        self.stateLabel.mj_origin.y = self.gifView.mj_origin.y + self.gifView.mj_size.height - 10
        
    }
}

