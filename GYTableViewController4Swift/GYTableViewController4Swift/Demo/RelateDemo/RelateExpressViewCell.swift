//
//  RelateExpressViewCell.swift
//  GYTableViewController4Swift
//
//  Created by gaoyang on 2019/2/5.
//  Copyright © 2019年 高扬. All rights reserved.
//

import UIKit

class RelateExpressViewCell: GYTableViewCell {
    
    private static let LEFT_AREA_WIDTH:CGFloat = 100
    private static let NORMAL_ROUTE_RADIUS:CGFloat = 5
    private static let FIRST_ROUTE_RADIUS:CGFloat = 7
    
    //MARK: 设置选中效果
    override var isSelected:Bool {
        set {
            super.isSelected = newValue
            self.checkCellRelate()
        }
        get{
            return super.isSelected
        }
    }
    
    //MARK: 根据外部传入数据开始布局
    override func showSubviews() {
        self.backgroundColor = UIColor.white
        
        let expressModel:ExpressModel? = getData() as? ExpressModel
        
        if expressModel == nil {
            return
        }
        
        self.titleLabel.text = expressModel?.title
        self.titleLabel.sizeToFit()
        
        self.yearLabel.text = expressModel?.year
        self.yearLabel.sizeToFit()
        self.timeLabel.text = expressModel?.time
        self.timeLabel.sizeToFit()
        
        let gap:CGFloat = 3
        let baseY:CGFloat = (self.contentView.height - self.yearLabel.height - gap - self.timeLabel.height) / 2.0
        
        self.yearLabel.y = baseY
        self.timeLabel.y = self.yearLabel.maxY + gap
        self.yearLabel.centerX = RelateExpressViewCell.LEFT_AREA_WIDTH / 2.0
        self.timeLabel.centerX = self.yearLabel.centerX
        
        self.routeLine.x = RelateExpressViewCell.LEFT_AREA_WIDTH
        
        self.titleLabel.x = self.routeLine.maxX + 20
        self.titleLabel.centerY = self.contentView.height / 2.0
        
        self.checkCellRelate()
    }
    
    //MARK: 位于第一个或最后一个和中间段的选中未选中的Cell样式不同
    func checkCellRelate() {
        self.titleLabel.textColor = self.isSelected ? TVStyle.colorPrimaryExpress : TVStyle.colorTextPrimary
        self.yearLabel.textColor = self.titleLabel.textColor
        self.timeLabel.textColor = self.titleLabel.textColor
        var nodeColor:UIColor!
        if (self.isSelected) {
            nodeColor = TVStyle.colorPrimaryExpress
        }else{
            nodeColor = TVStyle.colorLine
        }
        if (self.isFirst) {
            self.drawFirstStyle(color: nodeColor)
        }else if(self.isLast){
            self.drawLastStyle(color: nodeColor)
        }else{
            self.drawNormalStyle(color: nodeColor)
        }
    }
    
    func drawFirstStyle(color:UIColor) {
        self.routeLine.height = self.contentView.height / 2.0
        self.routeLine.y = self.contentView.height / 2.0
        self.roundNode.size = CGSize.init(width: RelateExpressViewCell.FIRST_ROUTE_RADIUS * 2, height: RelateExpressViewCell.FIRST_ROUTE_RADIUS * 2)
        self.roundNode.layer.borderColor = color.cgColor
        self.roundNode.layer.borderWidth = 2
        self.roundNode.layer.cornerRadius = RelateExpressViewCell.FIRST_ROUTE_RADIUS
        self.roundNode.layer.masksToBounds = true
        self.roundNode.centerX = self.routeLine.centerX;
        self.roundNode.centerY = self.contentView.height / 2.0
        self.roundNode.backgroundColor = UIColor.white
    }
    
    func drawLastStyle(color:UIColor) {
        self.routeLine.height = self.contentView.height / 2.0
        self.routeLine.y = 0
        self.roundNode.size = CGSize.init(width: RelateExpressViewCell.FIRST_ROUTE_RADIUS * 2, height: RelateExpressViewCell.FIRST_ROUTE_RADIUS * 2)
        self.roundNode.layer.borderColor = color.cgColor
        self.roundNode.layer.borderWidth = 2
        self.roundNode.layer.cornerRadius = RelateExpressViewCell.FIRST_ROUTE_RADIUS
        self.roundNode.layer.masksToBounds = true
        self.roundNode.centerX = self.routeLine.centerX
        self.roundNode.centerY = self.contentView.height / 2.0
        self.roundNode.backgroundColor = UIColor.white
    }
    
    func drawNormalStyle(color:UIColor) {
        self.routeLine.height = self.contentView.height
        self.routeLine.y = 0
        self.roundNode.size = CGSize.init(width: RelateExpressViewCell.NORMAL_ROUTE_RADIUS * 2, height:RelateExpressViewCell.NORMAL_ROUTE_RADIUS * 2)
        self.roundNode.layer.borderColor = UIColor.clear.cgColor
        self.roundNode.layer.borderWidth = 0
        self.roundNode.layer.cornerRadius = RelateExpressViewCell.NORMAL_ROUTE_RADIUS
        self.roundNode.layer.masksToBounds = true
        self.roundNode.centerX = self.routeLine.centerX
        self.roundNode.centerY = self.contentView.height / 2.0
        self.roundNode.backgroundColor = color;
    }
    
    //MARK: 懒加载添加视图
    private lazy var titleLabel:UILabel = { () -> UILabel in
        let _titleLabel:UILabel = UICreationUtils.createLabel(TVStyle.sizeTextPrimary, color: TVStyle.colorTextPrimary)
        self.contentView.addSubview(_titleLabel)
        return _titleLabel
    }()
        
    private lazy var yearLabel:UILabel = { () -> UILabel in
        let _yearLabel:UILabel = UICreationUtils.createLabel(TVStyle.sizeTextSecondary, color: TVStyle.colorTextPrimary)
        self.contentView.addSubview(_yearLabel)
        return _yearLabel
    }()

    private lazy var timeLabel:UILabel = { () -> UILabel in
        let _timeLabel:UILabel = UICreationUtils.createLabel(TVStyle.sizeTextPrimary, color: TVStyle.colorTextPrimary)
        self.contentView.addSubview(_timeLabel)
        return _timeLabel
    }()
    
    private lazy var routeLine:UIView = { () -> UIView in
        let _routeLine:UIView = UIView()
        _routeLine.width = 2
        _routeLine.backgroundColor = TVStyle.colorLine
        self.contentView.addSubview(_routeLine)
        return _routeLine
    }()
    
    private lazy var roundNode:UIView = { () -> UIView in
        let _roundNode:UIView = UIView()
        self.contentView.addSubview(_roundNode)
        return _roundNode
    }()

}
