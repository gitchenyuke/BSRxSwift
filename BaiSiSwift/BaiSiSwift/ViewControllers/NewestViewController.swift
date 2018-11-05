//
//  NewestViewController.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/15.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import RxSwift

class NewestViewController: BSBaseViewController {

    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigation()
        
        view.backgroundColor = UIColor.orange
        
    }
    
}
