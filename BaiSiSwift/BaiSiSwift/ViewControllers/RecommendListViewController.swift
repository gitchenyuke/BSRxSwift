//
//  RecommendListViewController.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/19.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import MJRefresh
import Kingfisher
import RxDataSources

class RecommendListViewController: UIViewController {
    /// 数据类型
    var type: String!
    
    let viewModel = RecommendListViewModel.init()
    /// 多组分区样式
    var dataSource: RxTableViewSectionedReloadDataSource<GroupedJHSection>!
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.register(RecommendListCell.self, forCellReuseIdentifier: "RecommendListCell")
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        //tableView.tableFooterView = UIView.init()
        tableView.rowHeight = 50
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(view).offset(0)
        }
        
        initUI()
        bindModel()
    }
    
    func initUI() {
        
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
        
        dataSource = RxTableViewSectionedReloadDataSource<GroupedJHSection>(
            configureCell: { (ds, tableView, index, model) -> RecommendListCell in
                let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendListCell", for: index) as! RecommendListCell
                cell.reloadData(data: model)
                return cell
        })
        
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        
        viewModel.data
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

extension RecommendListViewController : UITableViewDelegate ,HeaderSectionDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let items = dataSource[indexPath.section].items
        let model = items[indexPath.row]
        return RecommendListCell.getCellHightData(data:model)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ListHeaderSctionView.init(frame: .zero)
        let secion = dataSource[section]
        headerView.delegate = self
        headerView.reloadData(data: secion.header!)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = ListFooterSctionView.init(frame: .zero)
        let secion = dataSource[section]
        let count:Int = secion.header?.top_comments?.count ?? 0
        
        if count == 0 {
            footerView.bgView.isHidden = true
        }else{
            footerView.bgView.isHidden = false
        }
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let secon = dataSource[section]
        return ListHeaderSctionView.getCellHightData(data:secon.header!)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let secion = dataSource[section]
        let count:Int = secion.header?.top_comments?.count ?? 0
        
        if count == 0 {return 0.5}
        return 18.5
    }
    // MARK: - HeaderSectionDelegate 代理方法
    func didSelectedHeader(data: JHListEntity) {
        let ctl = ListDetailViewController()
        ctl.headerEntity = data
        self.navigationController?.pushViewController(ctl, animated: true)
    }
}
