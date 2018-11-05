//
//  ListDetailViewController.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/11/1.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import MJRefresh
import Kingfisher
import RxDataSources

class ListDetailViewController: BSBaseTableViewController,BSRefreshable {
    
    var headerView: ListDetailHeaderView!
    var headerEntity: JHListEntity!
    
    // ViewModel
    let viewModel = ListDetailViewModel.init()
    var vmOutput: ListDetailViewModel.ListDetailOuput?
    
    /// dataSource
    var dataSource: RxTableViewSectionedReloadDataSource<DetailCommentSection>!

    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        bindViewModel()
    }
    
    func initUI() {
        
        headerView = ListDetailHeaderView.init(frame: .zero)
        headerView.reload(data: headerEntity)
        headerView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: ListDetailHeaderView.getHightData(data: headerEntity))
        
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        self.tableView.tableHeaderView = headerView
        view.addSubview(self.tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(view).offset(0)
        }
    }

    
    func bindViewModel() {
        
        viewModel.id = headerEntity.id
        
        dataSource = RxTableViewSectionedReloadDataSource<DetailCommentSection>(
        
            configureCell: { (ds, tableView, index, model) -> UITableViewCell in
                let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
                cell?.textLabel?.text = model.user?.username
                return cell!
        })
        
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        
        vmOutput = viewModel.transform(input: ListDetailViewModel.ListDetailInput())
        
        vmOutput?.sections.asDriver().drive(tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        let refreshHeader = initRefreshGifHeader(tableView) { [weak self] in
            self?.viewModel.page = "0"
            self?.viewModel.jsonNun = 0
            self?.viewModel.json = "0-20.json"
            self?.vmOutput?.requestCommand.onNext(false)
        }
        
        let refreshFooter = initRefreshFooter(tableView) { [weak self] in
            self?.vmOutput?.requestCommand.onNext(true)
        }
        
        vmOutput?.autoSetRefreshHeaderStatus(header: refreshHeader, footer: refreshFooter).disposed(by: rx.disposeBag)
        
        refreshHeader.beginRefreshing()
        
    }
    
}


extension ListDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
