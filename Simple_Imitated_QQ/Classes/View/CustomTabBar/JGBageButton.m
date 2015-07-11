//
//  JGBageButton.m
//  CustomTabBar
//
//  Created by JJetGu on 15/6/28.
//  Copyright (c) 2015年 JJetGu. All rights reserved.
//

#import "JGBageButton.h"

@implementation JGBageButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        [self setBackgroundImage:[UIImage resizedImageWithName:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    return self;
}

-(void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    
    if (badgeValue) {
        self.hidden = NO;
        // 设置文字
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        // 设置frame
        CGRect frame = self.frame;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        
        if (badgeValue.length > 1) {
            // 根据文字的尺寸，来算出宽度
            NSDictionary *attrs = @{NSFontAttributeName : self.titleLabel.font};
            CGFloat titleW = [badgeValue boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
            badgeW = titleW + 10;
        }
        
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
         //JGLog(@"%@",NSStringFromCGRect(self.frame));
    } else {
       self.hidden = YES;
    }
}
@end
