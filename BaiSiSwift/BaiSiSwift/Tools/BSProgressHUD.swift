//
//  BSProgressHUD.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/16.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import SVProgressHUD

enum HUDType {
    case success
    case error
    case loading
    case info
    case progress
}

class BSProgressHUD: NSObject {
    
    class func initBSProgressHUD() {
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 14.0))
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.setMinimumDismissTimeInterval(1)
    }
    
    class func showSuccess(_ status: String) {
        self.showBSProgressHUD(type: .success, status: status)
    }
    class func showError(_ status: String) {
        self.showBSProgressHUD(type: .error, status: status)
    }
    class func showLoading(_ status: String) {
        self.showBSProgressHUD(type: .loading, status: status)
    }
    class func showInfo(_ status: String) {
        self.showBSProgressHUD(type: .info, status: status)
    }
    class func showProgress(_ status: String, _ progress: CGFloat) {
        self.showBSProgressHUD(type: .success, status: status, progress: progress)
    }
    class func dismissHUD(_ delay: TimeInterval = 0) {
        SVProgressHUD.dismiss(withDelay: delay)
    }
}

extension BSProgressHUD {
    class func showBSProgressHUD(type: HUDType, status: String, progress: CGFloat = 0) {
        switch type {
        case .success:
            SVProgressHUD.showSuccess(withStatus: status)
        case .error:
            SVProgressHUD.showError(withStatus: status)
        case .loading:
            SVProgressHUD.show(withStatus: status)
        case .info:
            SVProgressHUD.showInfo(withStatus: status)
        case .progress:
            SVProgressHUD.showProgress(Float(progress), status: status)
        }
    }
}

