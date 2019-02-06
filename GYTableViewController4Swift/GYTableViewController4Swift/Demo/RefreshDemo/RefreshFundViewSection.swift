//
//  RefreshFundViewSection.swift
//  GYTableViewController4Swift
//
//  Created by gaoyang on 2019/2/4.
//  Copyright © 2019年 高扬. All rights reserved.
//

import UIKit

class RefreshFundViewSection: GYTableViewSection {

    //Mark:Section视图暂时使用原生的方法布局 以后可能封装成别的方法来代替
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = TVStyle.colorBackground
        //square用懒加载方式添加一个UIView方块，具体创建方式不赘述
        self.square.x = 0
        self.square.centerY = self.height / 2
        //titleLabel用懒加载方式添加一个普通UILabel，具体创建方式不赘述
        self.titleLabel.text = self.data as? String//将外部传入的sectionNode.sectionData显示到标题文本上
        self.titleLabel.sizeToFit()
        self.titleLabel.x = self.square.maxX + 10
        self.titleLabel.centerY = self.height / 2.0
        
        self.bottomLine.x = 0
        self.bottomLine.maxY = self.height
        self.bottomLine.width = self.width
    }
    
    //Mark:懒加载添加视图
    private lazy var titleLabel:UILabel = { () -> UILabel in
        let _titleLabel:UILabel = UILabel()
        _titleLabel.font = UIFont.systemFont(ofSize: 16);
        self.addSubview(_titleLabel)
        return _titleLabel
    }()
        
    private lazy var square:UIView = { () -> UIView in
        let _square:UIView = UIView()
        _square.backgroundColor = TVStyle.colorPrimaryFund
        _square.size = CGSize.init(width: 5, height: 18)
        self.addSubview(_square)
        return _square
    }()
    
    private lazy var bottomLine:UIView = { () -> UIView in
        let _bottomLine:UIView = UIView()
        _bottomLine.backgroundColor = TVStyle.colorLine
        _bottomLine.height = TVStyle.lineWidth
        self.addSubview(_bottomLine)
        return _bottomLine
    }()

}
