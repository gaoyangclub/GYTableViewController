//
//  RefreshHotViewCell.swift
//  GYTableViewController4Swift
//
//  Created by gaoyang on 2019/2/3.
//  Copyright © 2019年 高扬. All rights reserved.
//

import UIKit

class HomeFastItem: UIControl {
    
    var hotModel:HotModel?;
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.hotModel == nil {
            return
        }
        
        self.titleLable.text = self.hotModel?.title;
        self.titleLable.sizeToFit();
        
        self.iconView.image = UIImage.init(named: self.hotModel!.iconName);
        let nodeSizeWidth:CGFloat = 40;
        self.iconView.size = CGSize.init(width: nodeSizeWidth, height: nodeSizeWidth)
        
        self.titleLable.centerX = self.width / 2.0;
        self.iconView.centerX = self.titleLable.centerX ;
        let gap:CGFloat = 10;
        let baseY:CGFloat = (self.height - self.titleLable.height - self.iconView.height - gap) / 2.0;
        self.iconView.y = baseY;
        self.titleLable.y = self.iconView.maxY + gap;
    }
    
    private lazy var titleLable:UILabel = { () -> UILabel in
        let _titleLable:UILabel = UICreationUtils.createLabel(TVStyle.sizeTextPrimary, color: TVStyle.colorTextPrimary)
        self.addSubview(_titleLable)
        return _titleLable
    }()
        
    private lazy var iconView:UIImageView = { () -> UIImageView in
        let _iconView = UIImageView()
        self.addSubview(_iconView)
        return _iconView;
    }()
    
}

class RefreshHotViewCell: GYTableViewCell {
    
    /**
     * 批量创建HomeFastItem按钮实例，一字排开
     */
    override func showSubviews() {
        super.showSubviews()
        
        self.backgroundColor = UIColor.white;
        
        let hotModels:Array<HotModel> = self.getData() as! Array<HotModel>
        let itemWidth:CGFloat = self.contentView.width / CGFloat(hotModels.count);
        
        for i in 0..<hotModels.count {
            let hotModel:HotModel = hotModels[i];
            let item:HomeFastItem = HomeFastItem.init(frame: CGRect.zero);
            item.hotModel = hotModel;
            self.contentView.addSubview(item);
            item.frame = CGRect.init(x: CGFloat(i) * itemWidth, y: 0, width: itemWidth, height: self.contentView.height)
            //        item.tag = i;
        }
        
        self.bottomLine.x = 0;
        self.bottomLine.maxY = self.contentView.height;
        self.bottomLine.width = self.contentView.width;
    }
    
    private lazy var bottomLine:UIView = { () -> UIView in
        let _bottomLine = UIView()
        _bottomLine.backgroundColor = TVStyle.colorLine;
        _bottomLine.height = TVStyle.lineWidth;
        self.contentView.addSubview(_bottomLine);
        return _bottomLine
    }()

}
