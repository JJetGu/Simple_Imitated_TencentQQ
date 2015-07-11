//
//  JGTabBarViewController.m
//  CustomTabBar
//
//  Created by JJetGu on 15/6/28.
//  Copyright (c) 2015年 JJetGu. All rights reserved.
//

#import "JGTabBarViewController.h"

#import "JGMessageViewController.h"
#import "JGContactsViewController.h"
#import "JGDynamicViewController.h"

#import "JGTabBar.h"

@interface JGTabBarViewController ()<JGTabBarDelegate>
/**
 *  自定义的tabbar
 */
@property (nonatomic, weak) JGTabBar *customTabBar;

@end

@implementation JGTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化tabbar
    [self setupTabbar];
    
    // 初始化所有的子控制器
    [self setupAllChildViewControllers];
    
    //添加监听者---改变主题
    JGAddObsver(observerReloadImage:, CHANGEAPPTHEME);
}

- (void)dealloc
{
    JGRemoveObsver;
}

- (void)viewWillAppear:(BOOL)animated //一般在这个方法中才能显示完要显示的控件
{
    [super viewWillAppear:animated];
    
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

/**
 *  初始化tabbar
 */
- (void)setupTabbar
{
    JGTabBar *customTabBar = [[JGTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    
    self.customTabBar = customTabBar;
}

/**
 *  监听tabbar按钮的改变
 *  @param from   原来选中的位置
 *  @param to     最新选中的位置
 */
- (void)tabBar:(JGTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
    
    //当前显示的控制器
    self.currentNavController = self.viewControllers[self.selectedIndex];
}

/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
    //1.消息
    JGMessageViewController *message = [[JGMessageViewController alloc]init];
    message.tabBarItem.badgeValue = @"6";
    [self setupChildViewController:message title:@"消息" imageName:@"tab_recent_nor.png" selectedImageName:@"tab_recent_press.png"];
    
    // 2.联系人
    JGContactsViewController *contacts = [[JGContactsViewController alloc] init];
    [self setupChildViewController:contacts title:@"联系人" imageName:@"tab_buddy_nor.png" selectedImageName:@"tab_buddy_press.png"];
    
    // 3.动态
    JGDynamicViewController *dynamic = [[JGDynamicViewController alloc] init];
    //dynamic.tabBarItem.badgeValue = @".";
    [self setupChildViewController:dynamic title:@"动态" imageName:@"tab_qworld_nor.png" selectedImageName:@"tab_qworld_press.png"];
    
}

/**
 *  通知改变tabBarItem图片
 */
- (void)observerReloadImage:(NSNotificationCenter *)notif
{
#warning mark - 觉得自己在这里出来的不好，相当于全部控制器重新实例化
    [self.customTabBar removeFromSuperview];
    for (JGNavigationController *navVC in self.viewControllers) {
        [navVC removeFromParentViewController];
    }
    
    [self setupTabbar];
    [self setupAllChildViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    //1.设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [JGCommonUtil imageWithConfigureNamed:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [JGCommonUtil imageWithConfigureNamed:selectedImageName];
    if (iOS7) {
        childVc.tabBarItem.selectedImage =[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        childVc.tabBarItem.selectedImage = selectedImage;
    }
    
    // 2.包装一个导航控制器
    JGNavigationController *nav = [[JGNavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}

@end
