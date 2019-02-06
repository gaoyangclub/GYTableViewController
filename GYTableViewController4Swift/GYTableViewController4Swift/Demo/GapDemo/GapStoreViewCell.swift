//
//  GapStoreViewCell.swift
//  GYTableViewController4Swift
//
//  Created by gaoyang on 2019/2/5.
//  Copyright © 2019年 高扬. All rights reserved.
//

import UIKit

class GapStoreViewCell: GYTableViewCell {
    
    //MARK:根据外部传入数据开始布局
    override func showSubviews() {
        
        self.backgroundColor = UIColor.white
        
        let storeModel:StoreModel? = self.getData() as? StoreModel
        
        if (storeModel == nil) {
            return
        }
        
        let padding:CGFloat = 20
        let iconHeight:CGFloat = self.contentView.height - padding * 2
        
        self.iconView.sd_setImage(with: URL.init(string: storeModel!.iconName), completed: nil)
        self.iconView.size = CGSize.init(width:iconHeight, height:iconHeight)
        self.iconView.centerY = self.contentView.height / 2.0
        self.iconView.x = padding
        
        self.titleLabel.text = storeModel?.title
        self.titleLabel.sizeToFit()
        
        self.hotLabel.text = "月均人气" + storeModel!.hot
        self.hotLabel.sizeToFit()
        
        self.desLabel.text = storeModel?.des
        self.desLabel.sizeToFit()
        
        self.discountButton.setTitle(storeModel?.discount, for: UIControl.State.normal)
        
        self.titleLabel.x = self.iconView.maxX + padding
        self.hotLabel.x = self.titleLabel.x
        self.desLabel.x = self.titleLabel.x
        self.discountButton.x = self.titleLabel.x
        
        let gap:CGFloat = 5
        
        self.titleLabel.y = self.iconView.y
        self.hotLabel.y = self.titleLabel.maxY + gap
        self.desLabel.y = self.hotLabel.maxY + gap
        self.discountButton.maxY = self.iconView.maxY
    }
    
    //MARK:懒加载添加视图
    private lazy var iconView:UIImageView = { () -> UIImageView in
        let _iconView:UIImageView = UIImageView()
        _iconView.contentMode = UIView.ContentMode.scaleAspectFill
        self.contentView.addSubview(_iconView)
        return _iconView
    }()
    
    private lazy var titleLabel:UILabel = { () -> UILabel in
        let _titleLabel:UILabel = UICreationUtils.createLabel(TVStyle.sizeTextPrimary, color: TVStyle.colorTextPrimary)
        self.contentView.addSubview(_titleLabel)
        return _titleLabel
    }()
    
    private lazy var hotLabel:UILabel = { () -> UILabel in
        let _hotLabel:UILabel = UICreationUtils.createLabel(TVStyle.sizeTextSecondary, color: TVStyle.colorPrimaryStore)
        self.contentView.addSubview(_hotLabel)
        return _hotLabel
    }()
    
    private lazy var desLabel:UILabel = { () -> UILabel in
        let _desLabel:UILabel = UICreationUtils.createLabel(TVStyle.sizeTextSecondary, color: TVStyle.colorTextSecondary)
        self.contentView.addSubview(_desLabel)
        return _desLabel
    }()
    
    private lazy var discountButton:UIButton = { () -> UIButton in
        let _discountButton:UIButton = UIButton.init(type: UIButton.ButtonType.custom)
        
        _discountButton.titleLabel?.font = UIFont.systemFont(ofSize:TVStyle.sizeTextSecondary)
        _discountButton.setTitleColor(TVStyle.colorPrimaryStore, for: UIControl.State.normal)

        _discountButton.layer.cornerRadius = 5
        _discountButton.layer.masksToBounds = true
        
        _discountButton.layer.borderColor = TVStyle.colorPrimaryStore.cgColor
        _discountButton.layer.borderWidth = TVStyle.lineWidth
    
        _discountButton.size = CGSize.init(width: 30, height: 15)
        
        self.contentView.addSubview(_discountButton)
        
        return _discountButton
    }()



}
