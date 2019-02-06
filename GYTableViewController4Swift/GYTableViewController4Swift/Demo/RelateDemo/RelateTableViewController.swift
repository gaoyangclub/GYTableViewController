//
//  RelateTableViewController.swift
//  GYTableViewController4Swift
//
//  Created by gaoyang on 2019/2/5.
//  Copyright © 2019年 高扬. All rights reserved.
//

import UIKit

class RelateTableViewController: UIViewController {

    //MARK: 使用表格控件
    override func gy_useTableView() -> Bool {
        return true
    }
    
    //MARK: 设置tableView位置信息
    override func gy_getTableViewFrame() -> CGRect {
        self.operateArea.frame = CGRect.init(x: 0, y: 0, width: self.view.width, height: 70)
        let gap:CGFloat = 5
        return CGRect.init(x: 0, y: self.operateArea.height + gap, width: self.view.width, height: self.view.height - self.operateArea.height - gap)
    }
    
    //MARK: - delegate下拉刷新后根据选择控件选中情况设置selectedIndexPath，clickCellHighlight，clickCellMoveToCenter等属性
    override func headerRefresh(_ tableView: GYTableBaseView!) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            tableView.add(SectionNode.initWithParams({ sNode in
                sNode?.addCellNode(byList: CellNode.dividingCellNode(bySourceArray: 50, cellClass: RelateExpressViewCell.self, sourceArray: Mock.expressModels))
            }))
            tableView.selectedIndexPath = IndexPath.init(item: Int(self.steperSelectedIndex.value - 1), section: 0)
            tableView.clickCellHighlight = self.switchClickHighlight.isOn
            tableView.clickCellMoveToCenter = self.switchClickMoveToCenter.isOn
            tableView.headerEndRefresh(true)
        }
    }
    
    //MARK: - delegate监听选中某个Cell
    override func didSelectRow(_ tableView: GYTableBaseView!, indexPath: IndexPath!) {
        if(self.switchClickHighlight.isOn){
            self.steperSelectedIndex.value = Double(indexPath.row + 1)
        }
    }
    
    //MARK: 视图布局 父视图的位置最好在gy_getTableViewFrame方法中执行
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = TVStyle.colorBackground
        
        let toppadding:CGFloat = 30
        let bottompadding:CGFloat = self.operateArea.height - toppadding
        
        self.steperSelectedIndex.x = 20
        
        self.switchClickHighlight.centerX = self.operateArea.width / 2.0
        
        self.switchClickMoveToCenter.maxX = self.operateArea.width - 40
        
        self.steperSelectedIndex.centerY = toppadding + bottompadding / 2.0
        self.switchClickMoveToCenter.centerY = self.steperSelectedIndex.centerY
        self.switchClickHighlight.centerY = self.steperSelectedIndex.centerY
        
        self.labelSteperSelectedIndex.centerX = self.steperSelectedIndex.centerX
        self.labelClickHighlight.centerX = self.switchClickHighlight.centerX
        self.labelClickMoveToCenter.centerX = self.switchClickMoveToCenter.centerX
        
        self.labelSteperSelectedIndex.centerY = toppadding / 2.0
        self.labelClickHighlight.centerY = self.labelSteperSelectedIndex.centerY
        self.labelClickMoveToCenter.centerY = self.labelSteperSelectedIndex.centerY
    }
    
    @objc func p_steperChanged() {
        self.tableView.selectedIndexPath = IndexPath.init(item: Int(self.steperSelectedIndex.value - 1), section: 0)
        if (self.switchClickMoveToCenter.isOn) {
            self.tableView.moveSelectedIndexPathToCenter()
        }
    }
    
    @objc func p_highlightChanged() {
        self.tableView.clickCellHighlight = self.switchClickHighlight.isOn
    }
    
    @objc func p_moveToCenterChanged() {
        self.tableView.clickCellMoveToCenter = self.switchClickMoveToCenter.isOn
    }
    
    //MARK: 懒加载添加交互控件
    private lazy var operateArea:UIView = { () -> UIView in
        let _operateArea:UIView = UIView()
        _operateArea.backgroundColor = UIColor.white
        self.view.addSubview(_operateArea)
        return _operateArea
    }()
    
    private lazy var labelSteperSelectedIndex:UILabel = { () -> UILabel in
        let _labelSteperSelectedIndex:UILabel = UICreationUtils.createLabel(TVStyle.sizeTextPrimary, color: TVStyle.colorTextPrimary, text: "选中索引位置调整", sizeToFit: true, superView: self.operateArea)
        return _labelSteperSelectedIndex
    }()
    
    private lazy var steperSelectedIndex:UIStepper = { () -> UIStepper in
        let _steperSelectedIndex:UIStepper = UIStepper()
        _steperSelectedIndex.minimumValue = 1
        _steperSelectedIndex.maximumValue = Double(Mock.expressModels.count)
        _steperSelectedIndex.stepValue = 1
        _steperSelectedIndex.value = 1
        self.operateArea.addSubview(_steperSelectedIndex)
        _steperSelectedIndex.addTarget(self, action: #selector(p_steperChanged), for: UIControl.Event.valueChanged)
        
        return _steperSelectedIndex
    }()
        
    private lazy var labelClickHighlight:UILabel = { () -> UILabel in
        let _labelClickHighlight:UILabel = UICreationUtils.createLabel(TVStyle.sizeTextPrimary, color: TVStyle.colorTextPrimary, text: "点击选中Cell高亮", sizeToFit: true, superView: self.operateArea)
        return _labelClickHighlight
    }()
    
    private lazy var switchClickHighlight:UISwitch = { () -> UISwitch in
        let _switchClickHighlight:UISwitch = UISwitch()
        _switchClickHighlight.addTarget(self, action:#selector(p_highlightChanged), for:UIControl.Event.valueChanged)
        self.operateArea.addSubview(_switchClickHighlight)
        return _switchClickHighlight
    }()
    
    private lazy var labelClickMoveToCenter:UILabel = { () -> UILabel in
        let _labelClickMoveToCenter:UILabel = UICreationUtils.createLabel(TVStyle.sizeTextPrimary, color: TVStyle.colorTextPrimary, text: "选中Cell自动居中", sizeToFit: true, superView: self.operateArea)
        return _labelClickMoveToCenter
    }()
    
    private lazy var switchClickMoveToCenter:UISwitch = { () -> UISwitch in
        let _switchClickMoveToCenter:UISwitch = UISwitch()
        _switchClickMoveToCenter.addTarget(self, action:#selector(p_moveToCenterChanged), for:UIControl.Event.valueChanged)
        self.operateArea.addSubview(_switchClickMoveToCenter)
        return _switchClickMoveToCenter
    }()
}
