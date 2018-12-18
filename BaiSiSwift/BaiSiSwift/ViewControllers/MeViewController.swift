//
//  MeViewController.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/15.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MeViewController: BSBaseViewController {
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .vertical
        return UICollectionView.init(frame: .zero, collectionViewLayout: flowLayout).chain
        .backgroundColor(UIColor.white)
        .register(MeCollectionReusableView.self, forSectionHeaderWithReuseIdentifier: "MeCollectionReusableView")
        .register(MeCollectionViewCell.self, forCellWithReuseIdentifier: "MeCollectionViewCell").build
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        navigation.item.title = "我"
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(SafeAreaTopHeight)
            make.left.bottom.right.equalTo(view).offset(0)
        }
        
        /// 数据
        let items = Observable.just([SectionModel.init(model: "", items: [MeItemsEntity.init(ivCover: "tabbar_compose_idea", title: "审帖"),
                                                                          MeItemsEntity.init(ivCover: "tabbar_compose_photo", title: "排行榜"),
                                                                          MeItemsEntity.init(ivCover: "tabbar_compose_weibo", title: "我的收藏"),
                                                                          MeItemsEntity.init(ivCover: "tabbar_compose_lbs", title: "内容贡献榜"),
                                                                          MeItemsEntity.init(ivCover: "tabbar_compose_review", title: "随机穿越"),
                                                                          MeItemsEntity.init(ivCover: "tabbar_compose_more", title: "意见反馈")])])
        
        let dataScource = RxCollectionViewSectionedReloadDataSource<SectionModel<String,MeItemsEntity>> (
            
            configureCell: { (dataSource, collectionView, indexPath, entity) -> BSBaseCollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MeCollectionViewCell", for: indexPath) as! MeCollectionViewCell
            cell.ivCover.image = BSImaged(entity.ivCover)
            cell.labTitle.text = entity.title
            return cell
        },configureSupplementaryView: {(ds ,cv, kind, ip) in
            
            let section = cv.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: "MeCollectionReusableView", for: ip) as! MeCollectionReusableView
            section.btn.rx.tap.subscribe(onNext: { [weak self] (sender) in
                let loginVC = BSLoginWithRegiestController()
                self?.navigationController?.pushViewController(loginVC, animated: true)
            }).disposed(by: self.rx.disposeBag)
            return section
        })
        
        /// dataScource 绑定数据
        items.bind(to: collectionView.rx.items(dataSource: dataScource)).disposed(by: rx.disposeBag)
        /// 设置代理
        collectionView.rx.setDelegate(self).disposed(by: rx.disposeBag)
    }
}

extension MeViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: kScreenWidth, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:MeCellWithd, height: MeCellWithd + 25)
    }
}
