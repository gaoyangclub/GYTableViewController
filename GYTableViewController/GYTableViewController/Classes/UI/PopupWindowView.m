//
//  PopWindowView.m
//  GYTableViewController
//
//  Created by gaoyang on 2018/10/18.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import "PopupWindowView.h"
#import "UIView+GY.h"
#import "UICreationUtils.h"
#import "TVStyle.h"

@interface PopupWindowView() {
    UIColor *_tintColor;
}

@property (nonatomic, strong) UIControl *maskView;
@property (nonatomic, strong) UIView *popupView;//弹出的视图区域

@property (nonatomic, strong) UIView *titleArea;
@property (nonatomic, strong) UILabel *titleView;
@property (nonatomic, strong) UIControl *closeButton;

@property (nonatomic, assign, readonly) CGFloat titleAreaHeight;

@end

@implementation PopupWindowView

- (void)setContentArea:(UIView *)contentArea {
    _contentArea = contentArea;
    [self.popupView addSubview:contentArea];
    [self setNeedsLayout];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self setNeedsLayout];
}

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.maskView.frame = self.bounds;
    
    self.titleArea.width = self.popupView.width;
    
    self.titleView.textColor = self.tintColor;
    self.titleView.text = self.title;
    [self.titleView sizeToFit];
    self.titleView.center = CGPointMake(self.titleArea.width / 2., self.titleArea.height / 2.);
    
    self.closeButton.centerY = self.titleArea.height / 2.;
    self.closeButton.maxX = self.titleArea.width - 10;
    
    if (self.contentArea) {
        self.contentArea.y = self.titleArea.maxY;
        self.contentArea.x = 0;
        self.contentArea.width = self.popupView.width;
        self.contentArea.height = self.contentHeight;
    }
}

- (void)show {
//    self.opaque = YES;
    self.userInteractionEnabled = YES;
    
    UIView *parent = [self p_getParentView];
    [parent addSubview:self];
    
    self.frame = parent.bounds;
    
    [self viewWillAppear];
    
    self.maskView.alpha = 0;
    self.popupView.frame = CGRectMake(0, self.height, self.width, self.titleAreaHeight + self.contentHeight);
    [self bringSubviewToFront:self.popupView];
    [self setNeedsLayout];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 1;
        self.popupView.frame = CGRectMake(0, self.height - self.titleAreaHeight - self.contentHeight, self.width, self.titleAreaHeight + self.contentHeight);
    }];
}

- (void)dismiss {
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0;
        self.popupView.frame = CGRectMake(0, self.height, self.width, self.titleAreaHeight + self.contentHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)viewWillAppear {
    
}

- (UIView *)p_getParentView {
    return [[UIApplication sharedApplication].windows firstObject];
}

- (CGFloat)titleAreaHeight {
    return 46;
}

- (CGFloat)contentHeight {
    if (!_contentHeight) {
        _contentHeight = 300;
    }
    return _contentHeight;
}

- (UIColor *)tintColor {
    if (!_tintColor) {
        _tintColor = [UIColor blackColor];
    }
    return _tintColor;
}

- (UIControl *)maskView {
    if (!_maskView) {
        _maskView = [[UIControl alloc]init];
        _maskView.alpha = 0;
        _maskView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        [_maskView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_maskView];
    }
    return _maskView;
}

- (UIView *)popupView {
    if (!_popupView) {
        _popupView = [[UIView alloc]init];
        _popupView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_popupView];
    }
    return _popupView;
}

- (UIView *)titleArea {
    if (!_titleArea) {
        _titleArea = [[UIView alloc]init];
        _titleArea.backgroundColor = TVStyle.colorBackground;
        _titleArea.x = _titleArea.y = 0;
        _titleArea.height = self.titleAreaHeight;
        [self.popupView addSubview:_titleArea];
    }
    return _titleArea;
}

- (UILabel *)titleView {
    if (!_titleView) {
        _titleView = [[UILabel alloc] init];
        _titleView.font = [UIFont systemFontOfSize:17];
        [self.titleArea addSubview:_titleView];
    }
    return _titleView;
}

- (UIControl *)closeButton {
    if (!_closeButton) {
        _closeButton = [[UIControl alloc]init];
        _closeButton.size = CGSizeMake(30, 30);
        
        [_closeButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self.titleArea addSubview:_closeButton];
        
        CGSize closeLayerSize = CGSizeMake(14, 14);
        CALayer *closeLayer = [UICreationUtils createCloseLayer:closeLayerSize color:self.tintColor strokeWidth:2];
        [_closeButton.layer addSublayer:closeLayer];
        closeLayer.frame = CGRectMake((_closeButton.size.width - closeLayerSize.width) / 2., (_closeButton.size.height - closeLayerSize.height) / 2., closeLayerSize.width, closeLayerSize.height);
    }
    return _closeButton;
}



@end
