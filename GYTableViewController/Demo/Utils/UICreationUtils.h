//
//  UICreationUtils.h
//  GYTableViewController
//
//  Created by 高扬 on 16/12/7.
//  Copyright © 2016年 admin. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UICreationUtils : NSObject

+(UILabel*)createLabel:(CGFloat)size color:(UIColor*)color;
+(UILabel*)createLabel:(CGFloat)size color:(UIColor*)color text:(NSString*)text sizeToFit:(BOOL)sizeToFit;
+(UILabel*)createLabel:(CGFloat)size color:(UIColor*)color text:(NSString*)text sizeToFit:(BOOL)sizeToFit superView:(UIView*)superView;

+(UILabel *)createLabel:(NSString *)fontName size:(CGFloat)size color:(UIColor *)color;
+(UILabel*)createLabel:(NSString*)fontName size:(CGFloat)size color:(UIColor*)color text:(NSString*)text sizeToFit:(BOOL)sizeToFit superView:(UIView*)superView;

+(UILabel*)createNavigationTitleLabel:(CGFloat)size color:(UIColor*)color text:(NSString*)text superView:(UIView*)superView;
//+(UIBarButtonItem*)createNavigationLeftButtonItem:(UIColor*)themeColor target:(id)target action:(SEL)action;
+(UIBarButtonItem*)createNavigationNormalButtonItem:(UIColor*)themeColor font:(UIFont*)font text:(NSString*)text target:(id)target action:(SEL)action;

+(CAShapeLayer*)createRangeLayer:(CGFloat)radius textColor:(UIColor*)textColor backgroundColor:(UIColor*)backgroundColor;
+(CAShapeLayer*)createRangeLayer:(CGFloat)radius textColor:(UIColor*)textColor backgroundColor:(UIColor*)backgroundColor isAdd:(BOOL)isAdd;
+(CAShapeLayer*)createPlusLayer:(CGFloat)radius color:(UIColor*)color strokeWidth:(CGFloat)strokeWidth isAdd:(BOOL)isAdd;

+(void)autoEnsureViewsWidth:(CGFloat)baseX totolWidth:(CGFloat)totolWidth views:(NSArray*)views viewWidths:(NSArray*)viewWidths padding:(CGFloat)padding;

@end
