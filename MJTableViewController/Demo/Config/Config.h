//
//  Config.h
//  MJTableViewController
//
//  Created by 高扬 on 2018/3/24.
//  Copyright © 2018年 高扬. All rights reserved.
//

#import <Foundation/Foundation.h>

#define rgb(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0]

#define COLOR_BACKGROUND rgb(243,243,243)
#define COLOR_LINE rgb(218,218,218)
#define LINE_WIDTH 0.5

#define COLOR_PRIMARY_FUND rgb(232,50,85)

#define COLOR_PRIMARY_DISHES rgb(45,155,235)

#define COLOR_PRIMARY_PRAISE rgb(253,98,54)

#define COLOR_PRIMARY_STORE rgb(232,32,71)

#define COLOR_PRIMARY_EXPRESS rgb(45,155,235)


#define COLOR_NOTICE_BACK rgb(108,179,233)


#define SIZE_TEXT_LARGE 16
#define SIZE_TEXT_PRIMARY 14
#define SIZE_TEXT_SECONDARY 12
#define SIZE_NAVI_TITLE 18

#define COLOR_TEXT_PRIMARY rgb(95,95,95)
#define COLOR_TEXT_SECONDARY rgb(155,155,155)

#define ICON_FONT_NAME @"iconfont"

#define ICON_ZHI_SHU @"\U0000e619"
#define ICON_ZHAI_QUAN @"\U0000e614"
#define ICON_BAO_BEN @"\U0000e6a3"
#define ICON_HUN_HE @"\U0000e63d"
#define ICON_ZHU_ZHUANG @"\U0000e6b2"
#define ICON_KAI_FANG @"\U0000e60c"
#define ICON_GU_PIAO @"\U0000e61f"
#define ICON_CHUANG_XIN @"\U0000e6de"
#define ICON_DUAN_QI @"\U0000e67c"
#define ICON_HUO_BI @"\U0000e663"

#define ICON_GUAN_ZHU @"\U0000e6bb"
#define ICON_DIAN_ZAN @"\U0000e629"

#define ICON_GONG_GAO @"\U0000e608"

@interface Config : NSObject


@end
