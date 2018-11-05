//
//  BSListViewController.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/16.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import MJRefresh
import Kingfisher
import RxDataSources

class BSListViewController: BSBaseTableViewController {
    
    var type: String!
    
    /// 单区样式
    var dataSource : RxTableViewSectionedReloadDataSource<JHListEntitySection>!
    
    let viewModel = BSListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        initUI()
        bindModel()
    }
    
    func initUI() {
        
        print("type\(type)")
        
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListTableViewCell")
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(view).offset(0)
        }
        
        tableView.mj_header =  MJRefreshNormalHeader.init(refreshingBlock: { [weak self] in
            self?.viewModel.json = "0-20.json"
            self?.viewModel.reload(type:self?.type ?? "", json: self?.viewModel.json ?? "")
        })
        
        tableView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: { [weak self] in
            self?.viewModel.reload(type:self?.type ?? "" ,json: self?.viewModel.json ?? "")
        })
        
        tableView.mj_header.beginRefreshing()
    }

    func bindModel() {
        
        dataSource = RxTableViewSectionedReloadDataSource<JHListEntitySection>(
            configureCell: { (ds, tableView, index, model) -> ListTableViewCell in
                let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: index) as! ListTableViewCell
                cell.reloadData(data: model)
                return cell
        })
        
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        
        ///绑定dataSource
        viewModel.datas
            .asObservable()
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        
        
        /// 结束刷新
        viewModel.refreshEnd.subscribe(onNext: { [weak self] () in
            self?.tableView.mj_header.endRefreshing()
            self?.tableView.mj_footer.endRefreshing()
        }).disposed(by: rx.disposeBag)
        
    }

}

extension BSListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let items = dataSource[indexPath.section].items
        let model = items[indexPath.row]
        return ListTableViewCell.getCellHightData(data:model)
    }
}


