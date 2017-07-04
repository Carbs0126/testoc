//
//  NewsListViewController.m
//  TestOC
//
//  Created by wangjianjun on 17/7/4.
//  Copyright © 2017年 wangjianjun. All rights reserved.
//

#import "NewsListViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "Masonry.h"
#import "MASConstraintMaker.h"
#import "UIView+Toast.h"
#import "LatestNews.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NewsCellView.h"

@implementation NewsListViewController

const static int text_color_normal = 0xffffffff;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStatusBarColor: GetColorFromHex(UI_COLOR_PRIMARY)];
    [self addTitleViewsToScreen];
    [self addTableViewToScreen];
    [self.tableView registerClass:[NewsCellView class] forCellReuseIdentifier:@"cell"];
    [self getNetData];
}

//更改statusbar颜色，即添加一个背景颜色为color的view
-(void) setStatusBarColor:(UIColor *) color{
    
    _statusBarView = [UIView new];
    _statusBarView.backgroundColor = color;
    
    //需要先添加这个view，然后进行约束
    [self.view addSubview:_statusBarView];
    
    [_statusBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, UI_STATUS_BAR_HEIGHT));
    }];
    
}

//添加顶部view
-(void) addTitleViewsToScreen{
    
    //添加顶部 title container
    _titleContainerView = [UIView new];
    _titleContainerView.backgroundColor = GetColorFromHex(UI_COLOR_PRIMARY);
    
    [self.view addSubview:_titleContainerView];
    
    [_titleContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_statusBarView.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, UI_TITLE_BAR_HEIGHT));
    }];
    
    //添加顶部中间的title label
    _titleLabelView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, UI_TITLE_BAR_HEIGHT)];
    
    _titleLabelView.text = @"知乎小报";
    _titleLabelView.textColor = GetColorFromHex(0xffffffff);
    _titleLabelView.font = [UIFont systemFontOfSize:16];
    _titleLabelView.textAlignment = NSTextAlignmentCenter;
    _titleLabelView.backgroundColor = GetColorFromHex(0);
    [_titleContainerView addSubview: _titleLabelView];
    
    
    //添加右侧设置button
    _buttonSettings = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [_buttonSettings setFrame:CGRectMake(0, 0, 100, 50)];
    [_buttonSettings.titleLabel setFont:[UIFont systemFontOfSize: 14.0]];
    [_buttonSettings setTitle:@"设置" forState:UIControlStateNormal];
    [_buttonSettings setTitleColor:GetColorFromHex(text_color_normal) forState:UIControlStateNormal];
    [_buttonSettings addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [_titleContainerView addSubview:_buttonSettings];
    [_buttonSettings mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleContainerView).offset(0);
        make.right.equalTo(_titleContainerView).offset(-16);
    }];
    
}

-(void) addTableViewToScreen{
    _tableView = [UITableView new];
    _tableView.backgroundColor = GetColorFromHex(0xff990000);
    
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleContainerView.mas_bottom).offset(0);
        make.size.mas_equalTo(
                              CGSizeMake(
                                         self.view.frame.size.width,
                                         self.view.frame.size.height - UI_TITLE_BAR_HEIGHT - UI_STATUS_BAR_HEIGHT));
    }];
    
    //指定tableview的委托
    [_tableView setDelegate:self];
    
    //指定数据源
    [_tableView setDataSource:self];
}


-(void)buttonClicked:(id)sender{
    if (sender == _buttonSettings) {
        [self.view makeToast:@"This is a piece of toast."];
    }
}

- (void) getNetData{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //默认返回的是json数据格式，此时responseObject为NSDictionary格式，不能转换成json格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager
     GET:@"https://news-at.zhihu.com/api/4/news/latest"
     parameters:nil
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         [self inflateTableViewByConstentString: responseString];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
     }
     ];
    
}

-(void) inflateTableViewByConstentString: (NSString *) contentString{
    NSError *error;
    LatestNews *latestNews = [[LatestNews alloc] initWithString:contentString error:&error];
    self.stories = latestNews.stories;
    [_tableView reloadData];
}

//指定tableview有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return [self.stories count];
        default:
            return 0;
    }
}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: TableSampleIdentifier];
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]
//                initWithStyle: UITableViewCellStyleDefault
//                reuseIdentifier: TableSampleIdentifier];
//        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
//    }
//    
//    NSUInteger row = [indexPath row];
//    cell.textLabel.text = [self.stories objectAtIndex:row].title;
//    
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[[self.stories objectAtIndex:row].images objectAtIndex:0]]
//                      placeholderImage:[UIImage imageNamed:@"pic_mv.png"]];
//    
//    return cell;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    
    //[self.tableView registerClass:[NewsCellView class] forCellReuseIdentifier:@"cell"];
    
    NewsCellView *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NewsCellView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [cell setData: [self.stories objectAtIndex:[indexPath row]]];
    
    return cell;
}


//下面两个方法的重载，是为了更改状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
}

@end


/*
 常量定义的一种方式:
 1. constants.h
 FOUNDATION_EXPORT const int UI_STATUS_BAR_HEIGHT;
 FOUNDATION_EXPORT const int UI_COLOR_PRIMARY;
 2. constants.m
 const int UI_STATUS_BAR_HEIGHT = 20;
 const int UI_COLOR_PRIMARY = 0xff1e7ad9;
 3. 将contants.h加入到pch中
 */


/*
 UIButton的使用：
 1. 没有设置状态的backgroundcolor
 2. 设置点击背景颜色改变
 
 [buttonSettings addTarget:self action:@selector(buttonSettingsDown:) forControlEvents:UIControlEventTouchDown];
 [buttonSettings addTarget:self action:@selector(buttonSettingsUpside:) forControlEvents:UIControlEventTouchUpInside];
 
 - (void)buttonSettingsDown:(UIButton *)sender
 {
 sender.backgroundColor = GetColorFromHex(bg_color_pressed);
 }
 
 - (void)buttonSettingsUpside:(UIButton *)sender
 {
 sender.backgroundColor = GetColorFromHex(bg_color_normal);
 }
 3. 添加点击事件
 [_buttonSettings addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
 
 -(void)buttonClicked:(id)sender{
 if (sender == _buttonSettings) {
 _titleLabelView.text = @"点击了设置按钮";
 }
 }
 
 */

/*
 AFNetworking的使用方法：
 1.默认返回的数据是json格式
 //AFHTTPResponseSerializer 返回的数据类型为二进制类型
 //AFJSONResponseSerializer 返回数据类型为json类型
 //AFXMLParserResponseSerializer xml类型
 manager.responseSerializer = [AFHTTPResponseSerializer serializer];
 */






