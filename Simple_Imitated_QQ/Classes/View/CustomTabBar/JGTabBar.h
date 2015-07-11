//
//  JGTabBar.h
//  CustomTabBar
//
//  Created by JJetGu on 15/6/28.
//  Copyright (c) 2015年 JJetGu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JGTabBar;

@protocol JGTabBarDelegate <NSObject>

@optional
- (void)tabBar:(JGTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface JGTabBar : UIView

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property (nonatomic, weak) id<JGTabBarDelegate> delegate;

@end
