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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigation()
        
        navigation.item.title = "最新"
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        navigationController?.pushViewController(TestController(), animated: true)
    }
    
    
}


