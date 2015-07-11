//
//  JGTabBarButton.m
//  CustomTabBar
//
//  Created by JJetGu on 15/6/28.
//  Copyright (c) 2015年 JJetGu. All rights reserved.
//

#import "JGTabBarButton.h"
#import "JGBageButton.h"

// 图标的比例
#define IWTabBarButtonImageRatio 0.6

// 按钮的默认文字颜色
#define  IWTabBarButtonTitleColor (iOS7 ? [UIColor blackColor] : [UIColor whiteColor])
// 按钮的选中文字颜色
#define  IWTabBarButtonTitleSelectedColor (iOS7 ? IWColor(29, 165, 232) : IWColor(248, 139, 0))

@interface JGTabBarButton ()
/**
 *  提醒数字
 */
@property (nonatomic, weak) JGBageButton *badgeButton;
@end

@implementation JGTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 图标居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        // 文字颜色
        [self setTitleColor:IWTabBarButtonTitleColor forState:UIControlStateNormal];
        [self setTitleColor:IWTabBarButtonTitleSelectedColor forState:UIControlStateSelected];
        
        if (!iOS7) { // 非iOS7下,设置按钮选中时的背景
            [self setBackgroundImage:[UIImage imageWithName:@"tabbar_slider"] forState:UIControlStateSelected];
        }
        
        // 添加一个提醒数字按钮
        JGBageButton *badgeButton = [[JGBageButton alloc]init];
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin; // 是它一直黏在右上角
        [self addSubview:badgeButton];
        
        self.badgeButton = badgeButton;
    }
    
    return self;
}

// 重写去掉高亮状态
- (void)setHighlighted:(BOOL)highlighted {}

// 内部图片的frame
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * IWTabBarButtonImageRatio;
    return CGRectMake(0, 0, imageW, imageH);
}

// 内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * IWTabBarButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

// 设置item
-(void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    // KVO 监听属性改变---实现外面可以动态改变这些属性
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

//一定要移除，就像通知那样子
- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}

/**
 *  监听到某个对象的属性改变了,就会调用
 *
 *  @param keyPath 属性名
 *  @param object  哪个对象的属性被改变
 *  @param change  属性发生的改变
 */

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 设置文字
    [self setTitle:self.item.title forState:UIControlStateSelected];
    [self setTitle:self.item.title forState:UIControlStateNormal];
    
    // 设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    // 设置提醒数字
    self.badgeButton.badgeValue = self.item.badgeValue;
    
    // 设置提醒数字的位置-- 这里只要设置 x y 就可以了
    CGFloat badgeY = 2;
    CGFloat badgeX = self.frame.size.width - self.badgeButton.frame.size.width - 10;
    
    CGRect badgeF = self.badgeButton.frame;
    badgeF.origin.x = badgeX - 10; ///-------临时减去的数据
    badgeF.origin.y = badgeY;
    self.badgeButton.frame = badgeF;
    //JGLog(@"%@",NSStringFromCGRect(self.badgeButton.frame));
}
@end















