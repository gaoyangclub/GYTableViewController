//
//  RefreshBannerViewCell.swift
//  GYTableViewController4Swift
//
//  Created by gaoyang on 2019/2/3.
//  Copyright © 2019年 高扬. All rights reserved.
//

import UIKit

class RefreshBannerViewCell: GYTableViewCell,SDCycleScrollViewDelegate {
    
    override func showSubviews() {
        self.cycleScrollView.frame = self.contentView.bounds;
        self.cycleScrollView.imageURLStringsGroup = self.getData() as? Array
    }

    private lazy var cycleScrollView:SDCycleScrollView = { () -> SDCycleScrollView in
        let _cycleScrollView:SDCycleScrollView = SDCycleScrollView.init(frame: CGRect.zero, delegate: self, placeholderImage: nil)
        _cycleScrollView.autoScrollTimeInterval = 5.0;//间隔5秒轮播
        _cycleScrollView.bannerImageViewContentMode = UIView.ContentMode.scaleAspectFill;
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        self.contentView.addSubview(_cycleScrollView);
        
        return _cycleScrollView
    }()

}
