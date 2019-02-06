//
//  FrameDishesViewCell.swift
//  GYTableViewController4Swift
//
//  Created by gaoyang on 2019/2/4.
//  Copyright © 2019年 高扬. All rights reserved.
//

import UIKit

class FrameDishesViewCell: GYTableViewCell {
    
    //MARK:根据外部传入数据开始布局
    override func showSubviews() {
        
        self.backgroundColor = UIColor.white;
        
        let dishesModel:DishesModel? = self.getData() as? DishesModel
        
        let padding:CGFloat = 10
        let iconHeight:CGFloat = self.contentView.height - padding * 2
        self.iconView.sd_setImage(with: URL.init(string: dishesModel!.iconName), completed: nil)
        self.iconView.size = CGSize.init(width: iconHeight, height: iconHeight)
        //    self.iconView.backgroundColor = [UIColor orangeColor];
        self.iconView.centerY = self.contentView.height / 2.0
        self.iconView.x = 20
        
        self.titleLabel.text = dishesModel?.title
        self.titleLabel.sizeToFit()
        self.desLabel.text = dishesModel?.des
        self.desLabel.sizeToFit()
        
        self.titleLabel.x = self.iconView.maxX + 20
        self.desLabel.x = self.titleLabel.x
        
        let vGap:CGFloat = 10
        let baseY:CGFloat  = (self.contentView.height - self.titleLabel.height - self.desLabel.height - vGap) / 2.0
        self.titleLabel.y = baseY
        self.desLabel.y = self.titleLabel.maxY + vGap
        
        self.priceLabel.text = "¥ " + dishesModel!.price
        self.priceLabel.sizeToFit()
        self.priceLabel.maxX = self.contentView.width - 30
        self.priceLabel.centerY = self.titleLabel.centerY
        
        self.bottomLine.x = 0
        self.bottomLine.maxY = self.contentView.height
        self.bottomLine.width = self.contentView.width
    }
    
    //MARK:设置cell点击效果
    override func showSelectionStyle() -> Bool {
        return true
    }

    //MARK:懒加载添加视图
    private lazy var iconView:UIImageView = { () -> UIImageView in
        let _iconView:UIImageView = UIImageView()
        _iconView.contentMode = UIView.ContentMode.scaleAspectFill
        self.contentView.addSubview(_iconView)
        return _iconView
    }()
    
    private lazy var titleLabel:UILabel = { () -> UILabel in
        let _titleLabel:UILabel = UICreationUtils.createLabel(TVStyle.sizeTextLarge, color: TVStyle.colorTextPrimary)
        self.contentView.addSubview(_titleLabel)
        return _titleLabel
    }()
    
    private lazy var desLabel:UILabel = { () -> UILabel in
        let _desLabel:UILabel = UICreationUtils.createLabel(TVStyle.sizeTextPrimary, color: TVStyle.colorTextSecondary)
        self.contentView.addSubview(_desLabel)
        return _desLabel
    }()
    
    private lazy var priceLabel:UILabel = { () -> UILabel in
        let _priceLabel:UILabel = UICreationUtils.createLabel(TVStyle.sizeTextPrimary, color: TVStyle.colorPrimaryFund)
        self.contentView.addSubview(_priceLabel)
        return _priceLabel
    }()

    private lazy var bottomLine:UIView = { () -> UIView in
        let _bottomLine:UIView = UIView()
        _bottomLine.backgroundColor = TVStyle.colorLine
        _bottomLine.height = TVStyle.lineWidth
        self.contentView.addSubview(_bottomLine)
        return _bottomLine
    }()

}
