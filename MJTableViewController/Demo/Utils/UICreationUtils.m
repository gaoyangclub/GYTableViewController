
//
//  UICreationUtils.m
//  BestDriverTitan
//
//  Created by admin on 16/12/7.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "UICreationUtils.h"

@implementation UICreationUtils

+(UILabel*)createNavigationTitleLabel:(CGFloat)size color:(UIColor*)color text:(NSString*)text superView:(UIView*)superView{
    UILabel* uiLabel = [UICreationUtils createLabel:size color:color text:text sizeToFit:YES superView:superView];
    if (superView) {
        uiLabel.center = superView.center;//手动对齐
    }
    return uiLabel;
}

//+(UIBarButtonItem*)createNavigationLeftButtonItem:(UIColor*)themeColor target:(id)target action:(SEL)action{
//    UIBarButtonItem* buttonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:(UIBarButtonItemStylePlain) target:target action:action];
////    UIBarButtonItem* buttonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemDone) target:target action:action];
//    UIArrowView* customView = [[UIArrowView alloc]initWithFrame:CGRectMake(0, 0, 10, 22)];
//    customView.direction = ArrowDirectLeft;
//    ////        customView.isClosed = true
//    customView.lineColor = themeColor;//UIColor.whiteColor()
//    customView.lineThinkness = 2;
//    ////        customView.fillColor = UIColor.blueColor()
//    buttonItem.customView = customView;
//    [customView addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
////    customView.showTouchEffect = YES;
//    [customView setShowTouch:YES];
//    return buttonItem;
//}

+(UIBarButtonItem*)createNavigationNormalButtonItem:(UIColor*)themeColor font:(UIFont*)font text:(NSString*)text target:(id)target action:(SEL)action{
    UIBarButtonItem* buttonItem = [[UIBarButtonItem alloc]initWithTitle:text style:(UIBarButtonItemStylePlain) target:target action:action];
    [buttonItem setTitleTextAttributes:@{NSFontAttributeName:font} forState:(UIControlStateNormal)];
    [buttonItem setTitleTextAttributes:@{NSFontAttributeName:font} forState:(UIControlStateSelected)];
    [buttonItem setTintColor:themeColor];
    return buttonItem;
}

+(UILabel*)createLabel:(CGFloat)size color:(UIColor*)color{
    return [UICreationUtils createLabel:size color:color text:@"" sizeToFit:NO superView:nil];
}

+(UILabel*)createLabel:(CGFloat)size color:(UIColor*)color text:(NSString*)text sizeToFit:(BOOL)sizeToFit{
    return [UICreationUtils createLabel:size color:color text:text sizeToFit:sizeToFit superView:nil];
}

+(UILabel*)createLabel:(CGFloat)size color:(UIColor*)color text:(NSString*)text sizeToFit:(BOOL)sizeToFit superView:(UIView*)superView{
    return [UICreationUtils createLabel:nil size:size color:color text:text sizeToFit:sizeToFit superView:superView];
}

+(UILabel *)createLabel:(NSString *)fontName size:(CGFloat)size color:(UIColor *)color{
    return [UICreationUtils createLabel:fontName size:size color:color text:@"" sizeToFit:NO superView:nil];
}

+(UILabel *)createLabel:(NSString *)fontName size:(CGFloat)size color:(UIColor *)color text:(NSString *)text sizeToFit:(BOOL)sizeToFit superView:(UIView *)superView{
    UILabel* uiLabel = [[UILabel alloc]init];
    if (fontName) {
        uiLabel.font = [UIFont fontWithName:fontName size:size];
    }else{
        uiLabel.font = [UIFont systemFontOfSize:size];//UIFont(name: "Arial Rounded MT Bold", size: size)
    }
    if(superView){
        [superView addSubview:uiLabel];
    }
    uiLabel.textColor = color;
    uiLabel.text = text;
    uiLabel.userInteractionEnabled = false; //默认没有交互
    if(sizeToFit){
        [uiLabel sizeToFit];
    }
    return uiLabel;
}

+(CAShapeLayer*)createRangeLayer:(CGFloat)radius textColor:(UIColor*)textColor backgroundColor:(UIColor*)backgroundColor{
    return [UICreationUtils createRangeLayer:radius textColor:textColor backgroundColor:backgroundColor isAdd:YES];
}

+(CAShapeLayer*)createRangeLayer:(CGFloat)radius textColor:(UIColor*)textColor backgroundColor:(UIColor*)backgroundColor isAdd:(BOOL)isAdd{
    CAShapeLayer* layer = [[CAShapeLayer alloc]init];
    CGRect rect = CGRectMake(0, 0, radius * 2, radius * 2);
    layer.frame = rect;
    
    UIBezierPath* path = [UIBezierPath bezierPathWithOvalInRect:rect];
    layer.fillColor = backgroundColor.CGColor;
    layer.path = path.CGPath;
    
    CAShapeLayer* pluslayer = [UICreationUtils createPlusLayer:radius color:textColor strokeWidth:2 isAdd:isAdd];
    
    [layer addSublayer:pluslayer];
    
    return layer;
}

+(CAShapeLayer*)createPlusLayer:(CGFloat)radius color:(UIColor*)color strokeWidth:(CGFloat)strokeWidth isAdd:(BOOL)isAdd{
    CGRect rect = CGRectMake(0, 0, radius * 2, radius * 2);
    
    CGFloat plusWidth = rect.size.width / 2;
    UIBezierPath* plusPath = [UIBezierPath bezierPath];
    [plusPath moveToPoint:CGPointMake(rect.size.width / 2. - plusWidth / 2. + 0.5,rect.size.height / 2. + 0.5)];
    [plusPath addLineToPoint:CGPointMake(rect.size.width / 2. + plusWidth / 2. + 0.5,rect.size.height / 2. + 0.5)];
    
    if(isAdd){
        [plusPath moveToPoint:CGPointMake(rect.size.width / 2. + 0.5,rect.size.height / 2. - plusWidth / 2. + 0.5)];
        [plusPath addLineToPoint:CGPointMake(rect.size.width / 2. + 0.5,rect.size.height / 2. + plusWidth / 2. + 0.5)];
    }
    CAShapeLayer* pluslayer = [[CAShapeLayer alloc]init];
    pluslayer.strokeColor = color.CGColor;
    pluslayer.lineWidth = strokeWidth;
    pluslayer.path = plusPath.CGPath;
    pluslayer.frame = rect;
    
    return pluslayer;
}

+(void)autoEnsureViewsWidth:(CGFloat)baseX totolWidth:(CGFloat)totolWidth views:(NSArray*)views viewWidths:(NSArray*)viewWidths padding:(CGFloat)padding{
    //当view隐藏的时候 后面的view自动往前移动
//    NSMutableArray* displayViews = [NSMutableArray array];
    CGFloat restWidth = totolWidth;
    
    CGFloat displayCount = 0;
    
    CGFloat totalPercent = 0;
    
    NSInteger tCount = views.count;
    for (NSInteger i = 0; i < tCount; i++) {
        UIView* view = views[i];
        if (!view.hidden) {
            displayCount++;
            
            NSObject* viewWidth = viewWidths[i];
            if ([viewWidth isKindOfClass:[NSNumber class]]) {
                restWidth -= ((NSNumber*)viewWidth).floatValue;//去掉固定值
            }else if([viewWidth isKindOfClass:[NSString class]]){
                NSString* string = (NSString*)viewWidth;
                string = [string substringToIndex:string.length - 1];//倒数第二个索引往前截取出来
                totalPercent += [string floatValue];
            }
        }
    }

//    NSInteger viewCount = displayViews.count;
    restWidth -= (displayCount + 1) * padding;//去掉gap
    
    CGFloat prevRight = 0;
    for (NSInteger i = 0; i < tCount; i++) {
        UIView* view = views[i];
        if (!view.hidden) {
            CGFloat vWidth = 0;
            NSObject* viewWidth = viewWidths[i];
            if ([viewWidth isKindOfClass:[NSNumber class]]) {
                vWidth = ((NSNumber*)viewWidth).floatValue;
            }else if([viewWidth isKindOfClass:[NSString class]]){
                NSString* string = (NSString*)viewWidth;
                string = [string substringToIndex:string.length - 1];//倒数第二个索引往前截取出来
                vWidth = [string floatValue] / totalPercent * restWidth;
            }
            CGFloat viewX = baseX + prevRight + padding;
            
            CGRect viewFrame = view.frame;
            viewFrame.origin.x = viewX;
            viewFrame.size.width = vWidth;
            view.frame = viewFrame;
            
            prevRight = viewX + vWidth;
        }
    }
    
}

@end
