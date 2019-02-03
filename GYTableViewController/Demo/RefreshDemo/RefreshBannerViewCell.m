//
//  RefreshBannerViewCell.m
//  GYTableViewController
//
//  Created by 高扬 on 2018/3/23.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "RefreshBannerViewCell.h"
#import "SDCycleScrollView.h"

@interface RefreshBannerViewCell()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@end

@implementation RefreshBannerViewCell

- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
        _cycleScrollView.autoScrollTimeInterval = 5.0;//间隔5秒轮播
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        [self.contentView addSubview:_cycleScrollView];
    }
    return _cycleScrollView;
}

#pragma mark 根据外部传入数据开始布局
- (void)showSubviews {
    self.cycleScrollView.frame = self.contentView.bounds;
    self.cycleScrollView.imageURLStringsGroup = GET_CELL_ARRAY_DATA([NSString class]); //self.data;
}


@end
