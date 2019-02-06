//
//  FrameTableViewController.swift
//  GYTableViewController4Swift
//
//  Created by gaoyang on 2019/2/4.
//  Copyright © 2019年 高扬. All rights reserved.
//

import UIKit

class FrameTableViewController: UIViewController {
    
    //MARK:使用该控件
    override func gy_useTableView() -> Bool {
        return true
    }
    
    //MARK:自定义上拉加载控件
    override func gy_getRefreshHeader() -> MJRefreshHeader! {
        return DiyRotateRefreshHeader()
    }
    
    //MARK:设置tableView位置信息
    //如存在和容器底部对齐的元素，请在此方法对齐底部位置(默认占满controller边界)；autoLayerout无需重写此方法，自行设置tableView和其他元素布局关系
    override func gy_getTableViewFrame() -> CGRect {
        
        self.noticeBack.frame = CGRect.init(x: 0, y: 0, width: self.view.width, height: 30)
    
        self.submitButton.maxY = self.view.height
    
        //返回设置好的tableView位置frame 高度=总高度-公告区高-底部按钮高
        return CGRect.init(x: 0, y: self.noticeBack.height, width: self.view.width, height:  self.view.height - self.noticeBack.height - self.submitButton.height);
    }
    
    //MARK: - delegate触发下拉刷新(交互或代码)
    override func headerRefresh(_ tableView: GYTableBaseView!) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            tableView.add(SectionNode.initWithParams({ sNode in
                sNode?.addCellNode(byList: CellNode.dividingCellNode(bySourceArray: 80, cellClass: FrameDishesViewCell.self, sourceArray: Mock.dishesModels))
            }))
            tableView.headerEndRefresh(true)
        }
    }
    
    //MARK: - delegate侦听选中的Cell并跳转页面
    override func didSelectRow(_ tableView: GYTableBaseView!, indexPath: IndexPath!) {
        let cNode:CellNode? = tableView.getCellNode(by: indexPath)
        let dishesModel:DishesModel? = cNode?.cellData as? DishesModel
        let webViewController:WebViewController = WebViewController()
        webViewController.linkUrl = dishesModel?.linkUrl
        webViewController.navigationTitle = dishesModel?.title
        self.navigationController?.pushViewController(webViewController, animated: true)
    }
    
    //MARK: 子视图布局 父视图的位置最好在getTableViewFrame方法中执行
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = TVStyle.colorBackground
        
        let leftMargin:CGFloat = 10
        
        self.noticeLabel.centerY = self.noticeBack.height / 2.0
        self.noticeIcon.centerY = self.noticeLabel.centerY
        self.noticeIcon.x = leftMargin
        self.noticeLabel.x = self.noticeIcon.maxX + leftMargin
        
        self.submitButton.x = 0
        self.submitButton.width = self.view.width
        self.submitButton.height = 50
    }
    
    //MARK: 懒加载添加视图
    private lazy var noticeBack:UIView = { () -> UIView in
        let _noticeBack:UIView = UIView()
        _noticeBack.backgroundColor = TVStyle.colorNoticeBack
        self.view.addSubview(_noticeBack)
        return _noticeBack
    }()
    
    private lazy var noticeIcon:UILabel = { () -> UILabel in
        let _noticeIcon:UILabel = UICreationUtils.createLabel(TVStyle.iconFontName, size: 16, color: UIColor.white, text: TVStyle.iconGongGao, sizeToFit: true, superView: self.noticeBack)
        return _noticeIcon
    }()
        
    private lazy var noticeLabel:UILabel = { () -> UILabel in
        let _noticeLabel:UILabel = UICreationUtils.createLabel(CGFloat(TVStyle.sizeTextSecondary), color: UIColor.white, text: "春季数码产品新款上市，全场3折，预购从速", sizeToFit: true, superView: self.noticeBack)
        return _noticeLabel
    }()

    private lazy var submitButton:UIButton = { () -> UIButton in
        let _submitButton = UIButton.init(type: UIButton.ButtonType.system)
        _submitButton.backgroundColor = TVStyle.colorPrimaryDishes
        _submitButton.setTitle("结   算", for: UIControl.State.normal)
        _submitButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        _submitButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(_submitButton)
        return _submitButton
    }()

}
