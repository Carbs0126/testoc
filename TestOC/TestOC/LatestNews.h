//
//  LatestNews.h
//  TestOC
//
//  Created by wangjianjun on 17/7/2.
//  Copyright © 2017年 wangjianjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "Story.h"

@interface LatestNews : JSONModel

@property (nonatomic) NSString* date;
@property (nonatomic) NSArray<Story>* stories;

@end
