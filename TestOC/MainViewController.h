//
//  MainViewController.h
//  TestOC
//
//  Created by wangjianjun on 17/6/30.
//  Copyright © 2017年 wangjianjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Story.h"

@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) UIView *statusBarView;
@property (nonatomic, retain) UIView *titleContainerView;
@property (nonatomic, retain) UILabel *titleLabelView;
@property (nonatomic, retain) UIButton *buttonSettings;
@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) NSArray<Story*> *stories;

@end
