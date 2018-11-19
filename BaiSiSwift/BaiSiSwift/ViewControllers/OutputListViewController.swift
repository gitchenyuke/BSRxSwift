//
//  OutputListViewController.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/22.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import MJRefresh
import Kingfisher
import RxDataSources
import DZNEmptyDataSet

class OutputListViewController: BSBaseTableViewController,BSRefreshable {
    
    // DataSource
    var dataSource : RxTableViewSectionedReloadDataSource<JHListEntitySection>!
    
    // ViewModel
    let viewModel = OutputViewModel.init()
    var vmOutput : OutputViewModel.BSListOuput?

    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        bindUI()
    }
    
    func initUI() {
        
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListTableViewCell")
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(view).offset(0)
        }
    }
    
    func bindUI() {
        
        dataSource = RxTableViewSectionedReloadDataSource<JHListEntitySection>(
            configureCell: { (ds, tableView, index, model) -> ListTableViewCell in
                let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: index) as! ListTableViewCell
                cell.reloadData(data: model)
                return cell
        })
        
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        
        vmOutput = viewModel.transform(input: OutputViewModel.BSListInput())
    
        vmOutput?.sections.asDriver().drive(tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        let refreshHeader = initRefreshGifHeader(tableView) { [weak self] in
            self?.vmOutput?.requestCommand.onNext("0-20.json")
        }
        
        let refreshFooter = initRefreshFooter(tableView) { [weak self] in
            self?.vmOutput?.requestCommand.onNext(self?.viewModel.json ?? "")
        }
        
        vmOutput?.autoSetRefreshHeaderStatus(header: refreshHeader, footer: refreshFooter).disposed(by: rx.disposeBag)
        
        refreshHeader.beginRefreshing()
    }
}


extension OutputListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let items = dataSource[indexPath.section].items
        let model = items[indexPath.row]
        return ListTableViewCell.getCellHightData(data:model)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let items = dataSource[indexPath.section].items
        let model = items[indexPath.row]
        let ctl = ListDetailViewController()
        ctl.headerEntity = model
        ctl.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(ctl, animated: true)
    }
}
