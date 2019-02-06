//
//  GapTableViewController.swift
//  GYTableViewController4Swift
//
//  Created by gaoyang on 2019/2/5.
//  Copyright © 2019年 高扬. All rights reserved.
//

import UIKit

class GapTableViewController: UIViewController {
    
    //MARK: 使用表格控件
    override func gy_useTableView() -> Bool {
        return true
    }
    
    //MARK: - delegate触发下拉刷新(交互或代码)
    override func headerRefresh(_ tableView: GYTableBaseView!) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            
            tableView.add(SectionNode.initWithParams({ sNode in
                sNode?.add(CellNode.initWithParams(150, cellClass: GapPraiseGroupCell.self, cellData: Mock.praiseModel))
            }))
            
            tableView.add(SectionNode.initWithParams({ sNode in
                sNode?.add(CellNode.initWithParams(70, cellClass: GapStoreHeaderCell.self, cellData: nil))
                sNode?.addCellNode(byList: CellNode.dividingCellNode(bySourceArray: 120, cellClass: GapStoreViewCell.self, sourceArray: Mock.storeModels))
            }))
            
            tableView.add(SectionNode.initWithParams({ sNode in
                sNode?.add(CellNode.initWithParams(150, cellClass: GapPraiseGroupCell.self, cellData: Mock.praiseModel))
            }))
            
            tableView.add(SectionNode.initWithParams({ sNode in
                sNode?.add(CellNode.initWithParams(70, cellClass: GapStoreHeaderCell.self, cellData: nil))
                sNode?.addCellNode(byList: CellNode.dividingCellNode(bySourceArray: 120, cellClass: GapStoreViewCell.self, sourceArray: Mock.storeModels))
            }))
            
            tableView.headerEndRefresh(true)
        }
    }
    
    //MARK: 设置间距
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.sectionGap = 6//设置每一节区域之间间距
        self.tableView.cellGap = 3//设置每个Cell之间间距(包含每一节区域)
        
        self.view.backgroundColor = TVStyle.colorBackground
    }

}
