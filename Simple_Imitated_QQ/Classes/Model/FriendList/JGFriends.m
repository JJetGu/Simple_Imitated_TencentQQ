//
//  JGFriends.m
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-7-10.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import "JGFriends.h"

@implementation JGFriends

-(instancetype)initWithDict:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}

+(instancetype)friendsWithDict:(NSDictionary *)dic
{
    return [[self alloc]initWithDict:dic];
}
@end
