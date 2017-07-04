//
//  NewsCellView.h
//  TestOC
//
//  Created by wangjianjun on 17/7/4.
//  Copyright © 2017年 wangjianjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Story.h"

@interface NewsCellView : UITableViewCell

@property (nonatomic, strong) UIImageView *cellImageView;
@property (nonatomic, strong) UILabel *cellLabel;
@property (nonatomic, strong) Story *story;

//+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setData:(Story *)story;

@end
