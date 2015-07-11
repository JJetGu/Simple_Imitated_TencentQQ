//
//  AppDelegate.h
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-6-30.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGLeftSlideViewController.h"
#import "JGTabBarViewController.h"

#define globalAppDelegate [[UIApplication sharedApplication] delegate]

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain)JGTabBarViewController *tabBarVC;
@property (nonatomic, strong)JGLeftSlideViewController *LeftSlideVC;

@end

