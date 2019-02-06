//
//  RefreshFundViewCell.swift
//  GYTableViewController4Swift
//
//  Created by gaoyang on 2019/2/4.
//  Copyright © 2019年 高扬. All rights reserved.
//

import UIKit

class RefreshFundViewCell: GYTableViewCell {
    
    override func showSubviews() {
        self.backgroundColor = UIColor.white
        
        let fundModel:FundModel? = getData() as? FundModel;
        if fundModel == nil {
            return
        }
        
        self.iconView.text = fundModel?.iconName;
        self.iconView.sizeToFit();
        self.iconView.centerY = self.contentView.height / 2.0;
        self.iconView.x = 20;
        
        self.titleLabel.text = fundModel?.title;
        self.titleLabel.sizeToFit();
        self.desLabel.text = fundModel?.des;
        self.desLabel.sizeToFit();
        
        self.titleLabel.x = self.iconView.maxX + 20
        self.desLabel.x = self.titleLabel.x
        
        let vGap:CGFloat = 10;
        let baseY:CGFloat = (self.contentView.height - self.titleLabel.height - self.desLabel.height - vGap) / 2.0;
        self.titleLabel.y = baseY;
        self.desLabel.y = self.titleLabel.maxY + vGap;
        
        self.rateLabel.text = "季度收益  " + fundModel!.rate
        self.rateLabel.sizeToFit();
        self.rateLabel.maxX = self.contentView.width - 30;
        self.rateLabel.centerY = self.desLabel.centerY;
        
        self.bottomLine.x = 0;
        self.bottomLine.maxY = self.contentView.height;
        self.bottomLine.width = self.contentView.width;

    }
    
    private lazy var iconView:UILabel = { () -> UILabel in
        let _iconView:UILabel = UICreationUtils.createLabel(TVStyle.iconFontName, size:30, color: TVStyle.colorPrimaryFund)
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
        
    private lazy var rateLabel:UILabel = { () -> UILabel in
        let _rateLabel:UILabel = UICreationUtils.createLabel(TVStyle.sizeTextPrimary, color: TVStyle.colorTextSecondary)
        self.contentView.addSubview(_rateLabel)
        return _rateLabel
    }()
        
    private lazy var bottomLine:UIView = { () -> UIView in
        let _bottomLine:UIView = UIView()
        _bottomLine.backgroundColor = TVStyle.colorLine
        _bottomLine.height = TVStyle.lineWidth
        self.contentView.addSubview(_bottomLine)
        return _bottomLine
    }()
    
}
