//
//  GapStoreHeaderCell.swift
//  GYTableViewController4Swift
//
//  Created by gaoyang on 2019/2/5.
//  Copyright © 2019年 高扬. All rights reserved.
//

import UIKit

class GapStoreHeaderCell: GYTableViewCell {
    
    //MARK:根据外部传入数据开始布局
    override func showSubviews() {
        
        self.backgroundColor = UIColor.white
        
        self.headerIconView.text = TVStyle.iconDianZan
        self.headerIconView.sizeToFit()
        
        self.titleLabel.text = "为你定制";//偷懒了 不从外面传了 重点是"间距间距间距" 重要的事说三遍
        self.titleLabel.sizeToFit()
        
        self.desLabel.text = "最好的陪伴是和爱的人一起吃饭";//偷懒了 不从外面传了 重点是"间距间距间距" 重要的事说三遍
        self.desLabel.sizeToFit()
        
        let gap:CGFloat = 5
        let baseX:CGFloat = (self.width - self.titleLabel.width - gap - self.headerIconView.width) / 2.0
        let baseY:CGFloat = (self.height - self.titleLabel.height - gap - self.desLabel.height ) / 2.0
        
        self.headerIconView.x = baseX
        self.headerIconView.y = baseY
        
        self.titleLabel.x = self.headerIconView.maxX + gap
        self.titleLabel.centerY = self.headerIconView.centerY
        
        self.desLabel.centerX = self.width / 2.0
        self.desLabel.y = self.titleLabel.maxY + gap
    }
    
    //MARK:懒加载添加视图
    private lazy var headerIconView:UILabel = { () -> UILabel in
        let _headerIconView:UILabel = UICreationUtils.createLabel(TVStyle.iconFontName, size:20, color: TVStyle.colorPrimaryStore)
        self.contentView.addSubview(_headerIconView)
        return _headerIconView
    }()
    
    private lazy var titleLabel:UILabel = { () -> UILabel in
        let _titleLabel:UILabel = UICreationUtils.createLabel(TVStyle.sizeTextPrimary, color: TVStyle.colorPrimaryStore)
        self.contentView.addSubview(_titleLabel)
        return _titleLabel
    }()
        
    private lazy var desLabel:UILabel = { () -> UILabel in
        let _desLabel:UILabel = UICreationUtils.createLabel(TVStyle.sizeTextSecondary, color: TVStyle.colorTextSecondary)
        self.contentView.addSubview(_desLabel)
        return _desLabel
    }()
    
}
