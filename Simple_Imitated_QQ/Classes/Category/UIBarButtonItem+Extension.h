//
//  UIBarButtonItem+Extension.h
//  CustomTabBar
//
//  Created by JJetGu on 15/6/28.
//  Copyright (c) 2015年 JJetGu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title image:(NSString *)image highImage:(NSString *)highImage;

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image selectedImage:(NSString *)selectedImage;
@end
