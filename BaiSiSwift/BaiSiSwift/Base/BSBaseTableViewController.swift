//
//  BSBaseTableViewController.swift
//  BaiSiSwift
//
//  Created by 陈宇科 on 2018/10/22.
//  Copyright © 2018 陈宇科. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class BSBaseTableViewController: BSBaseViewController,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    
    // View
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView.init()
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /// 设置空数据图片
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return BSPlaceholderImage()
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        paragraph.lineSpacing = CGFloat(NSLineBreakMode.byWordWrapping.rawValue)
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(15.0)), NSAttributedString.Key.foregroundColor: UIColor.red, NSAttributedString.Key.paragraphStyle: paragraph]
        return NSAttributedString(string: "真的没有数据！", attributes: attributes)
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    //显示空白页,默认是YES
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }

}
