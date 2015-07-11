//
//  AppDelegate.m
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-6-30.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import "AppDelegate.h"
#import "JGLeftViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];   //设置通用背景颜色
     [self.window makeKeyAndVisible];
    
    self.tabBarVC = [[JGTabBarViewController alloc]init];
    
    JGLeftViewController *leftVC = [[JGLeftViewController alloc]init];
    self.LeftSlideVC = [[JGLeftSlideViewController alloc]initWithLeftView:leftVC andMainView:self.tabBarVC ];
    self.window.rootViewController = self.LeftSlideVC;
    
    return YES;
}


@end
