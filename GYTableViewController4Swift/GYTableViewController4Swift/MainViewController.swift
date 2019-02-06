//
//  ViewController.swift
//  GYTableViewController4Swift
//
//  Created by gaoyang on 2019/2/3.
//  Copyright © 2019年 高扬. All rights reserved.
//

import UIKit

class ControllerNode: NSObject {
    
    var title:String?
    
    var controllerClass:UIViewController.Type?
    
    static func initWithTitle(_ title:String?, andClass controllerClass:UIViewController.Type?) -> ControllerNode {
        let controllerNode = ControllerNode()
        controllerNode.title = title;
        controllerNode.controllerClass = controllerClass;
        return controllerNode;
    }
}

class ControllerDemoViewCell: GYTableViewCell {
    
    override func showSubviews() {
        self.textLabel?.text = (self.getData() as? ControllerNode)?.title;
    }
    
    override func showSelectionStyle() -> Bool {
        return true
    }
    
}

class MainViewController: UIViewController {
    
    override func gy_useTableView() -> Bool {
        return true
    }
    
    override func gy_useRefreshHeader() -> Bool {
        return false
    }
    
    override func didSelectRow(_ tableView: GYTableBaseView!, indexPath: IndexPath!) {
        let cNode:CellNode = tableView.getCellNode(by: indexPath!)
        let controllerNode:ControllerNode? = cNode.cellData as? ControllerNode;
        let controllerClass:UIViewController.Type? = controllerNode?.controllerClass;
        let viewController:UIViewController? = controllerClass?.init()
        viewController?.title = controllerNode?.title;
        viewController?.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(viewController!, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "主页"
        
        self.tableView.add(SectionNode.initWithParams({ sNode in
            sNode?.addCellNode(byList: CellNode.dividingCellNode(bySourceArray: 50, cellClass: ControllerDemoViewCell.self, sourceArray: self.controllers))
        }))
        self.tableView.gy_reloadData()
    }
    
    private lazy var controllers:Array = [
        ControllerNode.initWithTitle("下拉刷新上拉加载示例", andClass: RefreshTableViewController.self),
        ControllerNode.initWithTitle("Table位置、自定义刷新、点击跳转示例", andClass: FrameTableViewController.self),
        ControllerNode.initWithTitle("Section或Cell间距示例", andClass: GapTableViewController.self),
        ControllerNode.initWithTitle("Cell上下关系和选中高亮示例", andClass: RelateTableViewController.self),
        ControllerNode.initWithTitle("Cell自动调整高度示例", andClass: AutoHeightTableViewController.self)
    ]

}

