//
//  JGMessageFrame.m
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-7-7.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import "JGMessageFrame.h"
#import "JGMessage.h"

#define bScreenWidth [[UIScreen mainScreen] bounds].size.width
#define bTimeLabelH 44

#define bIconW 50
#define bIconH 50

@implementation JGMessageFrame

-(void)setMessage:(JGMessage *)message
{
    _message = message;
    
    CGFloat margin = 10;
    
    //时间
    if (message.hideTime == NO) {
        CGFloat timeX = 0;
        CGFloat timeY = 0;
        CGFloat timeW = bScreenWidth;
        CGFloat timeH = bTimeLabelH;
        
        _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    }
    
    //头像
    CGFloat iconX;
    CGFloat iconY = CGRectGetMaxY(_timeF);
    CGFloat iconW = bIconW;
    CGFloat iconH = bIconH;
    
    if (message.type == JGMessageTypeGatsby) { // 自己发的
        iconX = bScreenWidth - iconW - margin;
    } else {
        iconX = margin;
    }
    _iconF =  CGRectMake(iconX, iconY, iconW, iconH);
    
    
    //正文
    
    CGFloat textX;
    CGFloat textY = iconY;
    
    CGSize textRealSize = [message.text boundingRectWithSize:CGSizeMake(150, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bBtnFont} context:nil].size;
    
    CGSize btnSize = CGSizeMake(textRealSize.width + 40, textRealSize.height + 40);
    
    if (message.type == JGMessageTypeGatsby) {
        textX = bScreenWidth - iconW - margin * 2 - btnSize.width;
    } else {
        textX = margin + iconW;
    }
    
    _textViewF = (CGRect){{textX,textY},btnSize};
    
    //Cell的高度
    CGFloat iconMaxY = CGRectGetMaxY(_iconF);
    CGFloat textMaxY = CGRectGetMaxY(_textViewF);
    
    _cellH = MAX(iconMaxY, textMaxY);
    
}



@end
