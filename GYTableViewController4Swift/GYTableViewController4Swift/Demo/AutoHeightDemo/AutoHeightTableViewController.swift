
//
//  AutoHeightTableViewController.swift
//  GYTableViewController4Swift
//
//  Created by gaoyang on 2019/2/5.
//  Copyright © 2019年 高扬. All rights reserved.
//

import UIKit

class AutoHeightTableViewController: UIViewController {

    //MARK: 使用该控件
    override func gy_useTableView() -> Bool {
        return true
    }
    
    //MARK: - delegate触发下拉刷新(交互或代码)
    override func headerRefresh(_ tableView: GYTableBaseView!) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            tableView.add(SectionNode.initWithParams({ sNode in
                sNode?.addCellNode(byList: CellNode.dividingCellNode(bySourceArray: CELL_AUTO_HEIGHT, cellClass: AutoHeightWeiboCell.self, sourceArray: Mock.weiboModels))
            }))
            tableView.headerEndRefresh(true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = TVStyle.colorBackground
    }
    

}
