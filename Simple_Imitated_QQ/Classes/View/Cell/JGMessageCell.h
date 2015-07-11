//
//  JGMessageCell.h
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-7-7.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JGMessageFrame;
@interface JGMessageCell : UITableViewCell

+(instancetype)messageCellWithTableView:(UITableView *)tableview;

//frame的模型
@property (nonatomic, strong) JGMessageFrame *messageFrame;


@end
