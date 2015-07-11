//
//  JGThemeCell.h
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15/7/4.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import "JGWaterflowViewCell.h"

@class JGWaterflowView;

@interface JGThemeCell : JGWaterflowViewCell

+ (instancetype)cellWithWaterflowView:(JGWaterflowView *)waterflowView;

- (void)themeSourcesArray:(NSArray *)array atIndex:(NSUInteger)index;

@end
