//
//  JGNavigationController.m
//  CustomTabBar
//
//  Created by JJetGu on 15/6/29.
//  Copyright (c) 2015年 JJetGu. All rights reserved.
//

#import "JGNavigationController.h"

@interface JGNavigationController ()

@end

@implementation JGNavigationController

+(void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    NSMutableDictionary *barTextAttrs = [[NSMutableDictionary alloc]init];
    barTextAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [bar setTitleTextAttributes:barTextAttrs];
    
    
    // 设置整个项目所有item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
     // 设置普通状态下UIBarButtonItem的字体颜色
    NSMutableDictionary *textAttrs = [[NSMutableDictionary alloc]init];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置不可用状态UIBarButtonItem的字体颜色
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7];
    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setBackgroundImage:[self loadImage] forBarMetrics:UIBarMetricsDefault];
}


- (UIImage *)loadImage
{
    NSString *imageName = nil;
    if (iOS7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)
    {
        imageName = @"header_bg_ios7.png";
    }else
    {
        imageName = @"header_bg.png";
    }
    UIImage *image = [JGCommonUtil imageWithConfigureNamed:imageName];
    
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
    if (self.viewControllers.count > 0) {
         /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        
        /* 设置导航栏上面的内容 */
        // 设置左边的返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) title:@"返回" image:@"back_normal.png" highImage:@"back_press.png"];
        
        // 设置右边的更多按钮
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more.png" highImage:@"navigationbar_more_highlighted.png"];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}

@end
