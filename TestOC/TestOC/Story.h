//
//  Story.h
//  TestOC
//
//  Created by wangjianjun on 17/7/2.
//  Copyright © 2017年 wangjianjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol Story;

@interface Story : JSONModel

@property (nonatomic) NSString* ga_prefix;
@property (nonatomic) NSString* id;
@property (nonatomic) NSArray<NSString*>* images;
@property (nonatomic) NSString<Optional>* multipic;
@property (nonatomic) NSString* title;
@property (nonatomic) NSString* type;

@end

/*
 当某个字段，可能存在也可能不存在时，添加<Optional>
 boolean int 等类型都可以使用NSString直接转化。
 true为1
 false为0
 */

