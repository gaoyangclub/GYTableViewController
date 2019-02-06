//
//  RefreshTableViewController.swift
//  GYTableViewController4Swift
//
//  Created by gaoyang on 2019/2/3.
//  Copyright © 2019年 高扬. All rights reserved.
//

import UIKit

class RefreshTableViewController: UIViewController {
    
    //MARK: - 使用该控件
    override func gy_useTableView() -> Bool {
        return true
    }
    
    //MARK: - 显示上拉加载更多控件
    override func gy_useLoadMoreFooter() -> Bool {
        return true
    }
    
    //MARK: - delegate触发下拉刷新(交互或代码)
    override func headerRefresh(_ tableView: GYTableBaseView!) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            tableView.add(SectionNode.initWithParams({ sNode in
                //添加一个高度为230，类型为BannerViewCell，展示banner图片列表的Cell
                sNode?.add(CellNode.initWithParams(230, cellClass: RefreshBannerViewCell.self, cellData: Mock.bannerUrlGroup, isUnique:true))
                //添加一个高度为90，类型为RefreshHotViewCell，展示标签按钮区域的Cell
                sNode?.add(CellNode.initWithParams(90, cellClass: RefreshHotViewCell.self, cellData:Mock.hotModels , isUnique:true))
            }))
            //设置页眉
            tableView.add(SectionNode.initWithParams(36, sectionHeaderClass: RefreshFundViewSection.self, sectionHeaderData: "精品专区", nextBlock: { sNode in
                sNode?.addCellNode(byList: CellNode.dividingCellNode(bySourceArray: 80, cellClass: RefreshFundViewCell.self, sourceArray: Mock.fundModels))
            }))
            tableView.headerEndRefresh(true)
        }
    }
    
    //MARK: - delegate触发上拉加载(交互或代码)
    override func footerLoadMore(_ tableView: GYTableBaseView!, last lastSectionNode: SectionNode!) {
        //模拟请求产生异步加载
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            if (tableView.getTotalCellNodeCount() > 30) {//总共超出30条数据不添加数据
                tableView.footerEndLoadMore(false) //直接结束上拉加载刷新，并显示"已经全部加载完毕"
                return;
            }
            //根据业务需求的不同，可以继续添加到上一节sectionNode，也可以添加到新的一节sectionNode中
            if (lastSectionNode.getCellNodeCount() < 15) {//上一节少于15条继续添加到上一节sectionNode
                lastSectionNode.addCellNode(byList: CellNode.dividingCellNode(bySourceArray: 80, cellClass: RefreshFundViewCell.self, sourceArray: Mock.fundNewModels))
            } else {//上一节超了 添加到新的一节sectionNode
                tableView.add(SectionNode.initWithParams(36, sectionHeaderClass: RefreshFundViewSection.self, sectionHeaderData: "推荐专区", nextBlock: { sNode in
                    sNode?.addCellNode(byList: CellNode.dividingCellNode(bySourceArray: 80, cellClass: RefreshFundViewCell.self, sourceArray: Mock.fundNewModels))
                }))
            }
            tableView.footerEndLoadMore(true)//不要忘了结束上拉加载刷新
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = TVStyle.colorBackground
    }

}
