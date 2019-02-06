//
//  TVStyle.h
//  GYTableViewController
//  表单样式相关
//  Created by gaoyang on 2019/2/6.
//  Copyright © 2019年 高扬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TVStyle : NSObject

@property (class, nonatomic, strong, readonly) UIColor *colorBackground;

@property (class, nonatomic, strong, readonly) UIColor *colorLine;

@property (class, nonatomic, strong, readonly) UIColor *colorPrimaryFund;

@property (class, nonatomic, strong, readonly) UIColor *colorPrimaryDishes;

@property (class, nonatomic, strong, readonly) UIColor *colorPrimaryPraise;

@property (class, nonatomic, strong, readonly) UIColor *colorPrimaryStore;

@property (class, nonatomic, strong, readonly) UIColor *colorPrimaryExpress;

@property (class, nonatomic, strong, readonly) UIColor *colorNoticeBack;

@property (class, nonatomic, strong, readonly) UIColor *colorTextPrimary;

@property (class, nonatomic, strong, readonly) UIColor *colorTextSecondary;

@property (class, nonatomic, assign, readonly) CGFloat lineWidth;

@property (class, nonatomic, assign, readonly) CGFloat sizeTextLarge;

@property (class, nonatomic, assign, readonly) CGFloat sizeTextPrimary;

@property (class, nonatomic, assign, readonly) CGFloat sizeTextSecondary;

@property (class, nonatomic, assign, readonly) CGFloat sizeNaviTitle;

@property (class, nonatomic, copy, readonly) NSString *iconFontName;

@property (class, nonatomic, copy, readonly) NSString *iconZhiShu;

@property (class, nonatomic, copy, readonly) NSString *iconZhaiQuan;

@property (class, nonatomic, copy, readonly) NSString *iconBaoBen;

@property (class, nonatomic, copy, readonly) NSString *iconHunHe;

@property (class, nonatomic, copy, readonly) NSString *iconZhuZhuang;

@property (class, nonatomic, copy, readonly) NSString *iconKaiFang;

@property (class, nonatomic, copy, readonly) NSString *iconGuPiao;

@property (class, nonatomic, copy, readonly) NSString *iconChuangXin;

@property (class, nonatomic, copy, readonly) NSString *iconDuanQi;

@property (class, nonatomic, copy, readonly) NSString *iconHuoBi;

@property (class, nonatomic, copy, readonly) NSString *iconGuanZhu;

@property (class, nonatomic, copy, readonly) NSString *iconDianZan;

@property (class, nonatomic, copy, readonly) NSString *iconGongGao;

@end

NS_ASSUME_NONNULL_END
