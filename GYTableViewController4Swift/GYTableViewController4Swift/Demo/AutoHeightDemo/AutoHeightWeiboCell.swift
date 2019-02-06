//
//  AutoHeightWeiboCell.swift
//  GYTableViewController4Swift
//
//  Created by gaoyang on 2019/2/5.
//  Copyright © 2019年 高扬. All rights reserved.
//

import UIKit

class AutoHeightWeiboCell: GYTableViewCell {

    public static let TOPIC_AREA_HEIGHT:CGFloat = 50
    public static let IMAGE_AREA_HEIGHT:CGFloat = 100
    public static let LEFT_PADDING:CGFloat = 60
    public static let RIGHT_PADDING:CGFloat = 10
    public static let BOTTOM_PADDING:CGFloat = 10

    //MARK: 获取动态高度,高度被缓存不会二次计算
    //    NSLog(@"getCellHeight被调用！");
    override func getHeight(_ cellWidth: CGFloat) -> CGFloat {
        let weiboModel:WeiboModel? = getData() as? WeiboModel//获取Model
        if weiboModel == nil {
            return 0
        }
        
        let content:String  = weiboModel!.content //获取动态内容字符串
        
        let contentSize:CGRect = content.boundingRect(with: CGSize.init(width: cellWidth - AutoHeightWeiboCell.LEFT_PADDING - AutoHeightWeiboCell.RIGHT_PADDING, height: CGFloat(Float.greatestFiniteMagnitude)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: TVStyle.sizeTextSecondary)], context: nil)
        //计算给定范围内最佳尺寸
        return AutoHeightWeiboCell.TOPIC_AREA_HEIGHT + contentSize.size.height + AutoHeightWeiboCell.IMAGE_AREA_HEIGHT + AutoHeightWeiboCell.BOTTOM_PADDING * 2;//返回计算后的最终高度
    }
    
    //MARK: 根据外部传入数据开始布局
    override func showSubviews() {
        self.backgroundColor = UIColor.white
        
        let weiboModel:WeiboModel? = getData() as? WeiboModel//获取Model
        if weiboModel == nil {
            return
        }
        
        self.iconView.sd_setImage(with: URL.init(string: weiboModel!.iconName), completed: nil)
        self.iconView.centerX = AutoHeightWeiboCell.LEFT_PADDING / 2.0
        self.iconView.centerY = AutoHeightWeiboCell.TOPIC_AREA_HEIGHT / 2.0
        
        self.nameLabel.text = weiboModel?.name
        self.nameLabel.sizeToFit()
        self.titleLabel.text = weiboModel?.title
        self.titleLabel.sizeToFit()
        
        let gap:CGFloat = 5
        let baseY:CGFloat = (AutoHeightWeiboCell.TOPIC_AREA_HEIGHT - self.nameLabel.height - gap - self.titleLabel.height) / 2.0
        self.nameLabel.y = baseY
        self.titleLabel.y = self.nameLabel.maxY + gap
        
        self.nameLabel.x = AutoHeightWeiboCell.LEFT_PADDING
        self.titleLabel.x = self.nameLabel.x
        
        self.contentLabel.text = weiboModel?.content;
        self.contentLabel.size = self.contentLabel.sizeThatFits(CGSize.init(width: self.contentView.width - AutoHeightWeiboCell.LEFT_PADDING - AutoHeightWeiboCell.RIGHT_PADDING, height: CGFloat(Float.greatestFiniteMagnitude)))
        self.contentLabel.x = AutoHeightWeiboCell.LEFT_PADDING
        self.contentLabel.y = AutoHeightWeiboCell.TOPIC_AREA_HEIGHT
        
        
        self.photoView.sd_setImage(with: URL.init(string: weiboModel!.imageUrl), completed: nil)
        self.photoView.frame = CGRect.init(x: AutoHeightWeiboCell.LEFT_PADDING, y: self.contentLabel.maxY + AutoHeightWeiboCell.BOTTOM_PADDING, width: self.contentLabel.width, height: AutoHeightWeiboCell.IMAGE_AREA_HEIGHT)
        
        self.bottomLine.x = 0
        self.bottomLine.maxY = self.contentView.height
        self.bottomLine.width = self.contentView.width
    }
    
    //MARK: 懒加载添加视图
    private lazy var iconView:UIImageView = { () -> UIImageView in
        let _iconView:UIImageView = UIImageView()
        _iconView.contentMode = UIView.ContentMode.scaleAspectFill
        let iconWidth:CGFloat = AutoHeightWeiboCell.LEFT_PADDING - 20
        _iconView.size = CGSize.init(width: iconWidth, height: iconWidth)
        _iconView.layer.cornerRadius = iconWidth / 2.0
        _iconView.layer.masksToBounds = true
        self.contentView.addSubview(_iconView)
        return _iconView
    }()
        
    private lazy var photoView:UIImageView = { () -> UIImageView in
        let _photoView:UIImageView = UIImageView()
        _photoView.contentMode = UIView.ContentMode.scaleAspectFill
        _photoView.layer.masksToBounds = true
        self.contentView.addSubview(_photoView)
        return _photoView
    }()
    
    private lazy var titleLabel:UILabel = { () -> UILabel in
        let _titleLabel:UILabel = UICreationUtils.createLabel(TVStyle.sizeTextSecondary, color: TVStyle.colorTextSecondary)
        self.contentView.addSubview(_titleLabel)
        return _titleLabel
    }()
        
    private lazy var nameLabel:UILabel = { () -> UILabel in
        let _nameLabel:UILabel = UICreationUtils.createLabel(TVStyle.sizeTextPrimary, color: TVStyle.colorTextPrimary)
        self.contentView.addSubview(_nameLabel)
        return _nameLabel
    }()
    
    private lazy var contentLabel:UILabel = { () -> UILabel in
        let _contentLabel:UILabel = UICreationUtils.createLabel(TVStyle.sizeTextSecondary, color: TVStyle.colorTextPrimary)
        _contentLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        _contentLabel.numberOfLines = 0
        self.contentView.addSubview(_contentLabel)
        return _contentLabel
    }()
        
    private lazy var bottomLine:UIView = { () -> UIView in
        let _bottomLine:UIView = UIView()
        _bottomLine.backgroundColor = TVStyle.colorLine
        _bottomLine.height = TVStyle.lineWidth
        self.contentView.addSubview(_bottomLine)
        return _bottomLine
    }()

}
