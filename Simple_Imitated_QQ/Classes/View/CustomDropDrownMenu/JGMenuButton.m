//
//  JGMenuButton.m
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15/7/4.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import "JGMenuButton.h"

// 图标的比例
#define JGMenuButtonImageRatio 0.6

@implementation JGMenuButton

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
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithRed:29/255.0 green:165/255.0 blue:232/255.0 alpha:1.0f] forState:UIControlStateSelected];
    }

    return self;
}

- (void)setHighlighted:(BOOL)highlighted {}


-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * JGMenuButtonImageRatio;
    return CGRectMake(0, 6, imageW, imageH);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * JGMenuButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

-(void)setContentArray:(NSArray *)contentArray
{
    _contentArray = contentArray;
    
    // 设置文字
    [self setTitle:[contentArray objectAtIndex:0] forState:UIControlStateSelected];
    [self setTitle:[contentArray objectAtIndex:0] forState:UIControlStateNormal];
    
    // 设置图片
    [self setImage:[JGCommonUtil imageWithConfigureNamed:[contentArray objectAtIndex:1]] forState:UIControlStateNormal];
    [self setImage:[JGCommonUtil imageWithConfigureNamed:[contentArray objectAtIndex:1]] forState:UIControlStateSelected];
}

@end
