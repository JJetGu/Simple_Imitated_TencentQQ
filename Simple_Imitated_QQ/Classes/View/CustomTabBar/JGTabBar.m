//
//  JGTabBar.m
//  CustomTabBar
//
//  Created by JJetGu on 15/6/28.
//  Copyright (c) 2015年 JJetGu. All rights reserved.
//

#import "JGTabBar.h"
#import "JGTabBarButton.h"

@interface JGTabBar ()
@property (nonatomic, weak) JGTabBarButton *selectedButton;
@end

@implementation JGTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[self loadImage]];
        //添加监听者---改变主题
        JGAddObsver(observerReloadImage:, CHANGEAPPTHEME);
        
    }
    return self;
}

- (void)dealloc
{
    JGRemoveObsver;
}

- (void)observerReloadImage:(NSNotificationCenter *)notif
{
     self.backgroundColor = [UIColor colorWithPatternImage:[self loadImage]];
}

- (UIImage *)loadImage
{
    NSString *imageName = nil;
    if (iOS7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)
    {
        imageName = @"tabbar_bg_ios7.png";
    }else
    {
        imageName = @"tabbar_bg.png";
    }
    UIImage *image = [JGCommonUtil imageWithConfigureNamed:imageName];
    
    return image;
}

-(void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    // 1.创建按钮
    JGTabBarButton *button = [[JGTabBarButton alloc]init];
    [self addSubview:button];
    
    // 2.设置数据
    button.item = item;
    
    // 3.监听按钮点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    // 4.默认选中第0个按钮
    if (self.subviews.count == 1) {
        [self buttonClick:button];
    }
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(JGTabBarButton *)button
{
    // 1.通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:button.tag];
    }
    
    // 2.设置按钮的状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 按钮的frame数据
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonY = 0;
    
    for (int index = 0; index < self.subviews.count; index++) {
        // 1.取出按钮
        JGTabBarButton *button = self.subviews[index];
        
        // 2.设置按钮的frame
        CGFloat buttonX = index * buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 3.绑定tag
        button.tag = index;
    }
}

@end
