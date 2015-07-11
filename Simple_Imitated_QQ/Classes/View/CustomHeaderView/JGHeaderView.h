//
//  JGHeaderView.h
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-7-10.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JGFriendsGroup;

typedef void(^JGHeaderViewBlock)(id);

@interface JGHeaderView : UITableViewHeaderFooterView

+(instancetype)headerViewWith:(UITableView *)tableView;

@property (nonatomic, strong) JGFriendsGroup *friendGroup;

@property (nonatomic, copy) JGHeaderViewBlock block;

@end
