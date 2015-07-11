//
//  JGTabBarViewController.h
//  CustomTabBar
//
//  Created by JJetGu on 15/6/28.
//  Copyright (c) 2015年 JJetGu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGNavigationController.h"

@interface JGTabBarViewController : UITabBarController

/**
 *  当前显示的试图控制器的导航栏
 */
@property (nonatomic, retain) JGNavigationController *currentNavController;

@end
