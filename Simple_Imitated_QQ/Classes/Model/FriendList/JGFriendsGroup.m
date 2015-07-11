//
//  JGFriendsGroup.m
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-7-10.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import "JGFriendsGroup.h"
#import "JGFriends.h"

@implementation JGFriendsGroup

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        //将所有值转化为模型
        [self setValuesForKeysWithDictionary:dict];
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in self.friends) {
            JGFriends *friendModel = [JGFriends friendsWithDict:dic];
            [array addObject:friendModel];
        }
        
        //将模型数组存入之前的self.friends普通数组
        self.friends = array;
    }
    
    return self;
}

+(instancetype)friendsGroupWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end
