//
//  JGMessageCell.m
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-7-7.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import "JGMessageCell.h"
#import "JGMessage.h"
#import "JGMessageFrame.h"

@interface JGMessageCell ()
//时间
@property (nonatomic, weak)UILabel *time;
//正文
@property (nonatomic, weak)UIButton *textView;
//用户头像
@property (nonatomic, weak)UIImageView *icon;

@end

@implementation JGMessageCell

+(instancetype)messageCellWithTableView:(UITableView *)tableview
{
    static NSString *ID = @"messageCell";
    JGMessageCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //1.时间
        UILabel *time = [[UILabel alloc]init];
        time.textAlignment = NSTextAlignmentCenter;
        time.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:time];
        self.time = time;
        
        //1.正文
        UIButton *textView = [[UIButton alloc]init];
        textView.titleLabel.font = bBtnFont;
        textView.titleLabel.numberOfLines = 0;//自动换行
        textView.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
        [textView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:textView];
        self.textView = textView;
        
        //1.头像
        UIImageView *icon = [[UIImageView alloc]init];
        [self.contentView addSubview:icon];
        self.icon = icon;
        
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

/**
 *  设置frame
 */
-(void)setMessageFrame:(JGMessageFrame *)messageFrame
{
    _messageFrame = messageFrame;
    
    JGMessage *messageModel = messageFrame.message;
    
    //时间
    self.time.frame = messageFrame.timeF;
    self.time.text = messageModel.time;
    
    //头像
    self.icon.frame = messageFrame.iconF;
    if (messageModel.type == JGMessageTypeGatsby) {
        self.icon.image = [UIImage imageNamed:@"Gatsby"];
    }else{
        self.icon.image = [UIImage imageNamed:@"Jobs"];
    }
    
    //3.正文
    self.textView.frame = messageFrame.textViewF;
    [self.textView setTitle:messageModel.text forState:UIControlStateNormal];
    
    //设置聊天显示的背景图片
    if (messageModel.type == JGMessageTypeGatsby) {
         [self.textView setBackgroundImage:[UIImage resizedImageWithName:@"chat_send_nor"] forState:UIControlStateNormal];
    } else {
        [self.textView setBackgroundImage:[UIImage resizedImageWithName:@"chat_recive_nor"] forState:UIControlStateNormal];
    }
}

@end
