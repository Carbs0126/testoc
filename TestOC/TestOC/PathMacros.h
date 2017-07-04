//
//  PathMacros.h
//  TestOC
//
//  Created by wangjianjun on 17/6/29.
//  Copyright © 2017年 wangjianjun. All rights reserved.
//

#ifndef PathMacros_h
#define PathMacros_h

//文件目录
#define kPathTemp                   NSTemporaryDirectory()
#define kPathDocument               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define kPathCache                  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]


#define GetColorFromHex(hexColor) \
[UIColor colorWithRed:((hexColor >> 16) & 0xFF) / 255.0 \
green:((hexColor >>  8) & 0xFF) / 255.0 \
blue:((hexColor >>  0) & 0xFF) / 255.0 \
alpha:((hexColor >> 24) & 0xFF) / 255.0]

#endif /* PathMacros_h */
