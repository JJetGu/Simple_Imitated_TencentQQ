//
//  JGFriends.h
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-7-10.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGFriends : NSObject

@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *icon;
//个性签名
@property (nonatomic, copy)NSString *intro;
//是否是vip
@property (nonatomic, assign,getter = isVip)BOOL vip;

-(instancetype)initWithDict:(NSDictionary *)dic;

+(instancetype)friendsWithDict:(NSDictionary *)dic;

@end
