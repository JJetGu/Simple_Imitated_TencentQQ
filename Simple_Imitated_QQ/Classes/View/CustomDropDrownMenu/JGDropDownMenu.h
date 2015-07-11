//
//  JGDropDownMenu.h
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-7-3.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JGDropDownMenu;

@protocol JGDropDownMenuDelegate<NSObject>

@optional
- (void)dropDownMenu:(JGDropDownMenu *)dropDownMenu pressAtIndex:(NSInteger)index;

@end

@interface JGDropDownMenu : UIView

@property (nonatomic, weak) id<JGDropDownMenuDelegate> delegate;

- (id)initWithFrame:(CGRect)frame contentArray:(NSArray *)array  backgroundImageName:(NSString *)imageName;

@end
