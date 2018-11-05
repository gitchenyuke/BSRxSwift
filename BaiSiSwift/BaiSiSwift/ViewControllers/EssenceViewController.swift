//
//  EssenceViewController.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/15.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import TYPagerController

class EssenceViewController: BSBaseViewController,ShadowNavImageLine {
    
    var titles:[EssenceSubmenusEntity]!
    
    let viewModel  = EssenceViewModel.init()

    lazy var tabBar :TYTabPagerBar = {
        let tabBar = TYTabPagerBar.init()
        tabBar.delegate = self
        tabBar.dataSource = self
        tabBar.layout.barStyle = .progressElasticView;
        tabBar.backgroundColor = UIColor.hexadecimalColor(hexadecimal: COLOR_NAV_BAR)
        tabBar.layout.normalTextFont = UIFont.systemFont(ofSize: FONT_MIDDLE);
        tabBar.layout.selectedTextFont = UIFont.systemFont(ofSize: FONT_MIDDLE);
        tabBar.layout.normalTextColor = UIColor.hexadecimalColor(hexadecimal: COLOR_BLACK_FOURTH)
        tabBar.layout.selectedTextColor = UIColor.white
        tabBar.layout.progressColor = UIColor.white
        tabBar.layout.cellEdging = 10;
        tabBar.layout.adjustContentCellsCenter = true
        tabBar.layout.adjustContentCellsCenter = true
        tabBar.register(TYTabPagerBarCell.self, forCellWithReuseIdentifier: TYTabPagerBarCell.cellIdentifier())
        return tabBar
    }()
    
    lazy var pageVC : TYPagerController = {
        let pageVC = TYPagerController.init()
        pageVC.dataSource = self
        pageVC.delegate = self
        return pageVC
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        hiddenLine()
        setUpNavigation()
        initUI()
        bindModel()

    }
    
    /// UI
    func initUI() {
        self.addChild(self.pageVC)
        view.addSubview(self.tabBar)
        view.addSubview(self.pageVC.view)
        
        self.tabBar.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(0)
            make.height.equalTo(45)
        }
        
        self.pageVC.view.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.bottom.equalTo(-SafeAreaBottomHeight)
            make.top.equalTo(self.tabBar.snp.bottom).offset(0)
        }
    }
    
    /// 绑定
    func bindModel() {

        viewModel.datas.asDriver().asObservable().subscribe(onNext: { [weak self] (model) in
            self?.titles = model
            if model.count > 0 {
                self?.tabBar.reloadData()
                self?.pageVC.reloadData()
            }
        }).disposed(by: rx.disposeBag)

    }

    override func leftItemClick() {
        print("碘酒了哈")
    }

}


extension EssenceViewController:TYPagerControllerDelegate,TYPagerControllerDataSource,TYTabPagerBarDataSource,TYTabPagerBarDelegate{
    // MARK: TYTabPagerBarDelegate
    func numberOfItemsInPagerTabBar() -> Int {
        return titles.count
    }
    
    func pagerTabBar(_ pagerTabBar: TYTabPagerBar, widthForItemAt index: Int) -> CGFloat {
        return 60
    }
    
    func pagerTabBar(_ pagerTabBar: TYTabPagerBar, didSelectItemAt index: Int) {
        self.pageVC.scrollToController(at: index, animate: true)
    }
    
    func pagerTabBar(_ pagerTabBar: TYTabPagerBar, cellForItemAt index: Int) -> UICollectionViewCell & TYTabPagerBarCellProtocol {
        let cell = pagerTabBar.dequeueReusableCell(withReuseIdentifier: TYTabPagerBarCell.cellIdentifier(), for: index)
        let entity = titles[index]
        
        cell.titleLabel.text = entity.name
        return cell
    }
    
    // MARK: TYPagerControllerDelegate
    func pagerController(_ pagerController: TYPagerController, controllerFor index: Int, prefetching: Bool) -> UIViewController {
        if index == 0 {
           return RecommendListViewController()
        }
        if index == 1 {
            return OutputListViewController()
        }
        return BSListViewController()
    }
    
    func pagerController(_ pagerController: TYPagerController, transitionFrom fromIndex: Int, to toIndex: Int, animated: Bool) {
        self.tabBar.scrollToItem(from: fromIndex, to: toIndex, animate: true)
    }
    
    func pagerController(_ pagerController: TYPagerController, transitionFrom fromIndex: Int, to toIndex: Int, progress: CGFloat) {
        self.tabBar.scrollToItem(from: fromIndex, to: toIndex, progress: progress)
    }
    
    func numberOfControllersInPagerController() -> Int {
        return titles.count
    }
}
