//
//  ViewController.m
//  TestOC
//
//  Created by wangjianjun on 17/6/27.
//  Copyright © 2017年 wangjianjun. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "Masonry.h"
#import "MASConstraintMaker.h"
#import "SplashViewController.h"
//#import "MainViewController.h"
#import "NewsListViewController.h"

@implementation SplashViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self addImageViewToScreen];
    [self startScaleAnimation:_imageView];
    [self addBottomViewsToScreen];
    
}

//添加 UIImageView
-(void) addImageViewToScreen{
    NSString *sourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *imagePath = [NSString stringWithFormat:@"%@/pic_mv.png", sourcePath];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
    _imageView = [[UIImageView alloc] initWithImage:image];
    _imageView.frame = [[UIScreen mainScreen] bounds];
    _imageView.backgroundColor = [UIColor redColor];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.view addSubview:_imageView];

}

//开始动画
-(void) startScaleAnimation:(UIView*) view {
    
    [UIView
        animateWithDuration:3
        animations:^{
            view.transform = CGAffineTransformMakeScale(1.2, 1.2);
        }
        completion:^(BOOL finished) {
            //动画执行完毕后的首位操作
            NSLog(@"动画执行完毕");
            [self checkNet];
        }
     ];
}

-(void) addBottomViewsToScreen{
    
    //添加底部view
    _bottomView = [UIView new];
    _bottomView.backgroundColor = GetColorFromHex(0x30000000);
    
    [self.view addSubview:_bottomView];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(0);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 100));
    }];

    //在底部view中添加一个UILabel
    _labelView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    _labelView.text = @"你好，世界！";
    _labelView.textColor = GetColorFromHex(0xccffffff);
    _labelView.font = [UIFont boldSystemFontOfSize:20];
    _labelView.textAlignment = NSTextAlignmentCenter;
    _labelView.backgroundColor = GetColorFromHex(0);
    [_bottomView addSubview: _labelView];
    
}

- (void) checkNet{
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case -1:
                NSLog(@"未知网络");
                break;
            case 0:
                NSLog(@"网络不可达");
                break;
            case 1:
                NSLog(@"GPRS网络");
                break;
            case 2:
                NSLog(@"wifi网络");
                break;
            default:
                break;
        }
        if(status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi)
        {
            NSLog(@"有网");
            [self performSelector:@selector(toMainViewControllerAfterSeconds) withObject:nil afterDelay: 2];
        }
        else
        {
            NSLog(@"没有网");
            [self showAlertControllerTitle:@"网络状态" andMessage:@"没  网"];
        }
    }];
    
}

//跳转
-(void) toMainViewControllerAfterSeconds{
//    MainViewController *mainVC = [[MainViewController alloc] init];
//    [self presentViewController:mainVC animated:YES completion:nil];
    NewsListViewController *listVC = [[NewsListViewController alloc] init];
    [self presentViewController:listVC animated:YES completion:nil];
    
//    NewsViewController *mainVC = [[NewsViewController alloc] init];
//    [self presentViewController:mainVC animated:YES completion:nil];
}


-(void) showAlertControllerTitle:(NSString *) alertTitle andMessage:(NSString *) alertMessage{
    //初始化提示框
    
    if (_alertController) {
        _alertController = nil;
    }
    
    _alertController = [UIAlertController
                                alertControllerWithTitle: alertTitle
                                message: alertMessage
                                preferredStyle: UIAlertControllerStyleAlert];
    
    [_alertController addAction:
        [UIAlertAction
            actionWithTitle: @"确定"
            style: UIAlertActionStyleDefault
            handler: ^(UIAlertAction * _Nonnull action) {
                //点击按钮的响应事件
            }
         ]
    ];
    //弹出提示框
    [self presentViewController:_alertController animated:true completion:nil];

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
 注意事项：
 1. 在工程中，不允许有相同名字的图片，这和 Android app 的要求不同；
 2. 图片的查找路径为 sourcePath + 图片名称，如果中间有路径，则不会找到；
 3. 动画效果，见函数 startScaleAnimation 的使用；
 */

/*
 第三方库的使用：
 1. 网络请求可以使用 AFNetworking
 2. 布局可以使用 Masonry。
 2.1 需要导入Masonry.h，否则提示找不到 mas_makeConstraints 方法；
 2.2 添加约束时，应该先把子view添加到父view中，然后添加约束，否则会出现找不到的错误：
 couldn't find a common superview for UIView
 3. pod安装第三方应用，需要完全退出工程，并在工程的主目录添加 Podfile, 并执行 pod install 命令
 */

/*
 使用预编译文件
 1. 新建一个或者多个头文件，并在头文件中定义多个常量
 2. 新建pch文件，import相关的头文件
 3. 更改工程配置：
 3.1 打开工程target 里边Building Setting中搜索Prefix Header，然后把Precompile Prefix Header右边的NO改为Yes；
 3.2 然后鼠标双击 prefix Header 行右侧空区域弹出输入框 输入"$(SRCROOT)/项目名称/pch文件名"
 */

/*
 TextView的使用：
 1. 如果不添加frame，可能不显示；
 2. 与TextField的区别是，后者只能显示一行，前者可以显示多行
 */


/*
 语言国际化：
 NSLocalizedString
 
 */

