//
//  DimensMacros.h
//  TestOC
//
//  Created by wangjianjun on 17/6/29.
//  Copyright © 2017年 wangjianjun. All rights reserved.
//

#ifndef DimensMacros_h
#define DimensMacros_h

//状态栏高度
#define STATUS_BAR_HEIGHT 20
//NavBar高度
#define NAVIGATION_BAR_HEIGHT 44
//状态栏 ＋ 导航栏 高度
#define STATUS_AND_NAVIGATION_HEIGHT ((STATUS_BAR_HEIGHT) + (NAVIGATION_BAR_HEIGHT))

//屏幕 rect
#define SCREEN_RECT ([UIScreen mainScreen].bounds)

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define CONTENT_HEIGHT (SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT)

//屏幕分辨率
#define SCREEN_RESOLUTION (SCREEN_WIDTH * SCREEN_HEIGHT * ([UIScreen mainScreen].scale))

//iphone适配比例
#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)480) < DBL_EPSILON)
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)
//横向适配比例
#define H_ADAPTER (IS_IPHONE_4*0.853333 + IS_IPHONE_5*0.853333 + IS_IPHONE_6 + IS_IPHONE_6_PLUS*1.104)
//纵向适配比例
#define V_ADAPTER (IS_IPHONE_4*0.719640 + IS_IPHONE_5*0.851574 + IS_IPHONE_6 + IS_IPHONE_6_PLUS*1.103448)

#endif /* DimensMacros_h */
