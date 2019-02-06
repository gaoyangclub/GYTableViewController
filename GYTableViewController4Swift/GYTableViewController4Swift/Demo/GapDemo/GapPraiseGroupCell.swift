//
//  GapPraiseGroupCell.swift
//  GYTableViewController4Swift
//
//  Created by gaoyang on 2019/2/5.
//  Copyright © 2019年 高扬. All rights reserved.
//

import UIKit

class GapPraiseItem: UIControl {
    
    var hotModel:HotModel?;
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.hotModel == nil {
            return
        }
        
        self.titleLable.text = self.hotModel?.title;
        self.titleLable.sizeToFit();
        
        self.iconView.sd_setImage(with: URL.init(string: hotModel!.iconName), completed: nil)
        self.iconView.frame = self.bounds
        
        self.titleLable.centerX = self.width / 2.0
        self.titleLable.maxY = self.height - 5
    }
    
    private lazy var titleLable:UILabel = { () -> UILabel in
        let _titleLable:UILabel = UICreationUtils.createLabel(TVStyle.sizeTextSecondary, color: UIColor.white)
        self.addSubview(_titleLable)
        return _titleLable
    }()
    
    private lazy var iconView:UIImageView = { () -> UIImageView in
        let _iconView = UIImageView()
        self.addSubview(_iconView)
        return _iconView;
    }()
}

class GapPraiseGroupCell: GYTableViewCell {
    
    //MARK: 添加三个GapPraiseItem实例，一字排开
    override func showSubviews() {
        self.backgroundColor = UIColor.white
        
        let praiseModel:PraiseModel? = self.getData() as? PraiseModel
        
        if (praiseModel == nil) {
            return
        }
        
        let toppadding:CGFloat = 50
        let padding:CGFloat = 15
        let gap:CGFloat = 5
        
        self.groupIconView.text = TVStyle.iconGuanZhu
        self.groupIconView.sizeToFit()
        
        self.groupTitleLable.text = praiseModel?.groupTitle
        self.groupTitleLable.sizeToFit()
        
        let baseX:CGFloat = (self.contentView.width - self.groupIconView.width - gap - self.groupTitleLable.width) / 2.0
        
        self.groupIconView.x = baseX
        self.groupTitleLable.x = self.groupIconView.maxX + gap
        self.groupIconView.centerY = toppadding / 2.0
        self.groupTitleLable.centerY = self.groupIconView.centerY

        let count:Int = praiseModel!.hotModels!.count
        let itemWidth:CGFloat = (self.contentView.width - padding * 2 - CGFloat(count - 1) * gap) / CGFloat(count)
        
        for i in 0..<count {
            let hotModel:HotModel? = praiseModel?.hotModels[i]
            let item:GapPraiseItem = GapPraiseItem()
            self.contentView.addSubview(item)
            item.hotModel = hotModel
            item.frame = CGRect.init(x: padding + CGFloat(i) * (itemWidth + gap), y: toppadding, width: itemWidth, height: self.height - toppadding - padding)
        }
        
    }

    private lazy var groupIconView:UILabel = { () -> UILabel in
        let _groupIconView:UILabel = UICreationUtils.createLabel(TVStyle.iconFontName, size:20, color: TVStyle.colorPrimaryPraise)
        self.contentView.addSubview(_groupIconView)
        return _groupIconView
    }()
        
    private lazy var groupTitleLable:UILabel = { () -> UILabel in
        let _groupTitleLable:UILabel = UICreationUtils.createLabel(TVStyle.sizeTextPrimary, color: TVStyle.colorPrimaryPraise)
        self.contentView.addSubview(_groupTitleLable)
        return _groupTitleLable
    }()
    
}
