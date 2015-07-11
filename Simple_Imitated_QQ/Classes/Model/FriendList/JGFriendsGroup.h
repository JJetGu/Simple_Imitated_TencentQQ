//
//  JGFriendsGroup.h
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-7-10.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGFriendsGroup : NSObject

//存放每行显示的内容
@property (nonatomic, strong)NSArray *friends;

//tableHeaderView 显示的名字
@property (nonatomic, copy)NSString *name;

//tableHeaderView 显示的在线人数
@property (nonatomic, assign)NSInteger online;

//判断是否展开
@property (nonatomic, assign)BOOL open;

//判读是否旋转剪头按钮
//@property (nonatomic, assign)BOOL canTransform;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)friendsGroupWithDict:(NSDictionary *)dict;

@end
