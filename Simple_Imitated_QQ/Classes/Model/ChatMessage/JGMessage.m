//
//  JGMessage.m
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-7-7.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import "JGMessage.h"

@implementation JGMessage

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict]; // 字典转模型
    }
    return self;
}

+(instancetype)messageWithDict:(NSDictionary *)dict
{
   return [[self alloc] initWithDict:dict];
}
@end
