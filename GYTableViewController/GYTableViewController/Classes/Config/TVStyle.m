//
//  TVStyle.m
//  GYTableViewController
//
//  Created by gaoyang on 2019/2/6.
//  Copyright © 2019年 高扬. All rights reserved.
//

#import "TVStyle.h"

#define rgb(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0]

@implementation TVStyle

+ (UIColor *)colorBackground {
    return rgb(243,243,243);
}

+ (UIColor *)colorLine {
    return rgb(218,218,218);
}

+ (UIColor *)colorPrimaryFund {
    return rgb(232,50,85);
}

+ (UIColor *)colorPrimaryDishes {
    return rgb(45,155,235);
}

+ (UIColor *)colorPrimaryPraise {
    return rgb(253,98,54);
}

+ (UIColor *)colorPrimaryStore {
    return rgb(232,32,71);
}

+ (UIColor *)colorPrimaryExpress {
    return rgb(45,155,235);
}

+ (UIColor *)colorNoticeBack {
    return rgb(108,179,233);
}

+ (UIColor *)colorTextPrimary {
    return rgb(95,95,95);
}

+ (UIColor *)colorTextSecondary {
    return rgb(155,155,155);
}

+ (CGFloat)lineWidth {
    return 0.5;
}

+ (CGFloat)sizeTextLarge {
    return 16;
}

+ (CGFloat)sizeTextPrimary {
    return 14;
}

+ (CGFloat)sizeTextSecondary {
    return 12;
}

+ (CGFloat)sizeNaviTitle {
    return 18;
}

+ (NSString *)iconFontName {
    return @"iconfont";
}

+ (NSString *)iconZhiShu {
    return @"\U0000e619";
}

+ (NSString *)iconZhaiQuan {
    return @"\U0000e614";
}

+ (NSString *)iconBaoBen {
    return @"\U0000e6a3";
}

+ (NSString *)iconHunHe {
    return @"\U0000e63d";
}

+ (NSString *)iconZhuZhuang {
    return @"\U0000e6b2";
}

+ (NSString *)iconKaiFang {
    return @"\U0000e60c";
}

+ (NSString *)iconGuPiao {
    return @"\U0000e61f";
}

+ (NSString *)iconChuangXin {
    return @"\U0000e6de";
}

+ (NSString *)iconDuanQi {
    return @"\U0000e67c";
}

+ (NSString *)iconHuoBi {
    return @"\U0000e663";
}

+ (NSString *)iconGuanZhu {
    return @"\U0000e6bb";
}

+ (NSString *)iconDianZan {
    return @"\U0000e629";
}

+ (NSString *)iconGongGao {
    return @"\U0000e608";
}

@end
