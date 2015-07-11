//
//  JGSearchBar.m
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-7-9.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#define CommonMainColor [UIColor colorWithHexString:@"2d2d2d"]

#import "JGSearchBar.h"

@implementation JGSearchBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.placeholder = @"搜索";
        [self setSearchFieldBackgroundImage:[[UIImage imageNamed:@"search_input"] resizableImageWithCapInsets:UIEdgeInsetsMake(15.0, 18.0, 15.0, 18.0)] forState:UIControlStateNormal];
        
        [self setBackgroundImage:[[UIImage imageNamed:@"search_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)]];
    }
    
    return self;
}

/**
 *  取消搜索框
 */
-(void)setCancelButton
{
    [self setShowsCancelButton:YES];
    [self setCancelButtonImage:[UIImage imageNamed:@"clear"] title:@"取消" forState:UIControlStateNormal forView:self];
}

/**
 *  设置搜索框取消按钮的背景颜色
 */
- (void)setCancelButtonImage:(UIImage *)image title:(NSString *)title forState:(UIControlState)state forView:(UIView *)view
{
    UIButton *cancelButton = nil;
    
    for (UIView *subView in view.subviews) {
        if([subView isKindOfClass:UIButton.class])
        {
            cancelButton = (UIButton *)subView;
            break;
        } else {
            //在上一层视图中继续找
            [self setCancelButtonImage:image title:title forState:state forView:subView];
        }
    }
    
    if (cancelButton) {
        [cancelButton setBackgroundColor:[UIColor clearColor]];
        [cancelButton setBackgroundImage:image forState:UIControlStateNormal];
        [cancelButton setBackgroundImage:image forState:UIControlStateHighlighted];
        [cancelButton setTitleColor:CommonMainColor forState:state];
        [UIColor colorWithHexString:@""];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        if ([[UIDevice currentDevice].systemVersion floatValue] <= 6.9) {
            [cancelButton setTitle:title forState:state];
        }
    }

}

@end
