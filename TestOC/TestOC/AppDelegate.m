//
//  AppDelegate.m
//  TestOC
//
//  Created by wangjianjun on 17/6/27.
//  Copyright © 2017年 wangjianjun. All rights reserved.
//

#import "AppDelegate.h"
#import "SplashViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    SplashViewController *appStartController = [[SplashViewController alloc] init];
    self.window.rootViewController = appStartController;
    
//    UINavigationController *nav = [[UINavigationController alloc] init];
//    self.window.rootViewController = nav;
//    SplashViewController *appStartController = [[SplashViewController alloc] init];
//    [nav setViewControllers:@[appStartController] animated:YES];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end































