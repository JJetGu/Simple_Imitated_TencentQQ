//
//  UIImage+Extention.h
//  CustomTabBar
//
//  Created by JJetGu on 15/6/28.
//  Copyright (c) 2015年 JJetGu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extention)
/**
 *  加载图片
 *
 *  @param name 图片名
 */
+ (UIImage *)imageWithName:(NSString *)name;

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;
@end
