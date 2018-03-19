//
//  ImageViewCell.m
//  MJTableViewController
//
//  Created by 高扬 on 2018/3/18.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "BannerViewCell.h"

@interface BannerViewCell()

@property(nonatomic,retain)UIImageView* bannerImageView;

@end

@implementation BannerViewCell

-(UIImageView *)bannerImageView{
    if (!_bannerImageView) {
        _bannerImageView = [[UIImageView alloc]init];
        _bannerImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bannerImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_bannerImageView];
    }
    return _bannerImageView;
}

-(void)showSubviews{
    int64_t delay = 0.3 * NSEC_PER_SEC;
    self.bannerImageView.image = nil;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{
        NSString* imageName = self.data;
        self.bannerImageView.image = [UIImage imageNamed:imageName];
        self.bannerImageView.frame = self.contentView.bounds;
    });
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//    // Configure the view for the selected state
//}

@end
