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
import CoreMedia
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
        headerView.playerManager.delegate = self
        headerView.reload(data: headerEntity)
        headerView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: ListDetailHeaderView.getHightData(data: headerEntity))
        
        tableView.register(BSCommentTableViewCell.self, forCellReuseIdentifier: "BSCommentTableViewCell")
        self.tableView.tableHeaderView = headerView
        self.tableView.tableFooterView = UIView.init()
        view.addSubview(self.tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(SafeAreaTopHeight)
            make.left.bottom.right.equalTo(view)
        }
    }

    
    func bindViewModel() {
        
        viewModel.id = headerEntity.id
        
        dataSource = RxTableViewSectionedReloadDataSource<DetailCommentSection>(
        
            configureCell: { (ds, tableView, index, model) -> UITableViewCell in
                let cell = tableView.dequeueReusableCell(withIdentifier: "BSCommentTableViewCell") as! BSCommentTableViewCell
                cell.reloadData(model)
                return cell
        })
        
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        
        vmOutput = viewModel.transform(input: ListDetailViewModel.ListDetailInput())
        
        /// 输出时 更新数据
        vmOutput?.sections.asDriver().drive(tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        let refreshHeader = initRefreshGifHeader(tableView) { [weak self] in
            self?.reloadData()
        }
        
        let refreshFooter = initRefreshFooter(tableView) { [weak self] in
            self?.vmOutput?.requestCommand.onNext(true)
        }
        
        vmOutput?.autoSetRefreshHeaderStatus(header: refreshHeader, footer: refreshFooter).disposed(by: rx.disposeBag)
        
        reloadData()
        
        //refreshHeader.beginRefreshing()
    }
    
    func reloadData() {
        self.viewModel.page = "0"
        self.viewModel.jsonNun = 0
        self.viewModel.json = "0-20.json"
        self.vmOutput?.requestCommand.onNext(false)
    }
    
    deinit {
        print("释放了")
        /// 停止播放
        headerView.playerManager.pause()
    }
    
}

// MARK: UITableViewDelegate
extension ListDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let items = dataSource[indexPath.section].items
        let model = items[indexPath.row]
        return BSCommentTableViewCell.getCellHightData(model)
    }
}


// MARK: PlayerManagerDelegate
extension ListDetailViewController: PlayerManagerDelegate{
    // 分享按钮点击回调
    func playerViewShare() {
        print("处理分享逻辑")
    }

    // 播放完成回调
    func playFinished() {
        print("播放完了😁")
    }
    
    // 返回按钮点击回调
    func playerViewBack() {
        navigationController?.popViewController(animated: true)
    }
}
