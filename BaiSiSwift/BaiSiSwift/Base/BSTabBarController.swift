//
//  BSTabBarController.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/15.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit

class BSTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        createSubViewControllers()
    }
    
    func createSubViewControllers(){
        
        let essenceVC    = EssenceViewController.init()
        let newestVC     = NewestViewController.init()
        let communityVC  = CommunityViewController.init()
        let meVC         = MeViewController.init()
        
        let essenceNav   = UINavigationController.init(rootViewController: essenceVC)
        let newestNav    = UINavigationController.init(rootViewController: newestVC)
        let communityNav = UINavigationController.init(rootViewController: communityVC)
        let meNav        = UINavigationController.init(rootViewController: meVC)
        
        addTabBarItem(essenceNav, title:"精华", imageNormal: "btn_home_normal", imageselected: "btn_home_selected")
        addTabBarItem(newestNav, title:"最新", imageNormal: "btn_live_normal", imageselected: "btn_live_selected")
        
        addTabBarItem(communityNav, title:"社区", imageNormal: "btn_column_normal", imageselected: "btn_column_selected")
        addTabBarItem(meNav, title:"我", imageNormal: "btn_user_normal", imageselected: "btn_user_selected")
        
        addChild(essenceNav)
        addChild(newestNav)
        addComButton()
        addChild(communityNav)
        addChild(meNav)
        
    }
    
    func addComButton() {
        let midBtn = UIButton.init(type: .custom)
        
        midBtn.setImage(UIImage.init(named: "btn_tabar_add"), for: .normal)
        
        midBtn.backgroundColor = UIColor.white
        
        midBtn.addTarget(self, action: #selector(self.minBtnClick), for: .touchUpInside)
        tabBar.addSubview(midBtn)
        
        midBtn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        midBtn.center = CGPoint(x: tabBar.frame.size.width*0.5, y: tabBar.frame.size.height*0.5)
        
        let vc = UIViewController.init()
        vc.tabBarItem.isEnabled = false
        
        addChild(vc)
    }
    
    func addTabBarItem(_ childNav:UINavigationController,title:String,imageNormal:String,imageselected:String) {
        // 标题
        childNav.tabBarItem.title = title
        // 未点击图标
        childNav.tabBarItem.image = UIImage.init(named: imageNormal)
        // 点击后的图标
        childNav.tabBarItem.selectedImage = UIImage.init(named: imageselected)?.withRenderingMode(.alwaysOriginal)
    }
    
    @objc func minBtnClick() {
        let ctl = BSComposeTypeViewController()
        self.present(ctl, animated: true, completion: nil)
    }

}
