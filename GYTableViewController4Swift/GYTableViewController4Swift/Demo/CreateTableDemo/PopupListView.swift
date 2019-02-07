//
//  PopupListView.swift
//  GYTableViewController4Swift
//
//  Created by gaoyang on 2019/2/7.
//  Copyright © 2019年 高扬. All rights reserved.
//

import UIKit

class PopupListView: PopupWindowView,GYTableBaseViewDelegate {
    
    public var dataArray:Array<Any>?
    
    private var tableView:GYTableBaseView?
    
    //MARK: - 在每次弹窗中都会执行viewWillAppear调整视图数据
    override func viewWillAppear() {
        
        //首次创建tableView，无上拉加载和下拉刷新控件的干净实例，并设置delegate
        if (self.tableView == nil) {
            self.tableView = GYTableBaseView.table(self);//创建并设置delegate
            //设置TableView底部Cell细线样式
            self.tableView?.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
            self.tableView?.separatorInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
            //设置需要pop的容器
            self.contentArea = self.tableView;
        } else {
            self.tableView?.clearAllSectionNode();//上一次的数据全部清除，dataArray的内容可能已经改变
        }
        
        self.tableView?.add(SectionNode.initWithParams({ sNode in
            sNode?.addCellNode(byList: CellNode.dividingCellNode(bySourceArray: 50, cellClass: PopupListViewCell.self, sourceArray: self.dataArray))
        }))
        
        self.tableView?.gy_reloadData();//不要忘了刷新Table
    }
    
    //MARK: - delegate选中后关闭弹窗
    func didSelectRow(_ tableView: GYTableBaseView!, indexPath: IndexPath!) {
        self.dismiss()
    }

}
