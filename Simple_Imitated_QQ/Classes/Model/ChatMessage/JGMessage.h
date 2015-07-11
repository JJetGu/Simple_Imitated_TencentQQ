//
//  JGMessage.h
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-7-7.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    JGMessageTypeGatsby = 0,
    JGMessageTypeJobs
}JGMessageType;

@interface JGMessage : NSObject

//正文
@property (nonatomic, copy)NSString *text;

//时间
@property (nonatomic, copy)NSString *time;

//发送类型
@property (nonatomic, assign)JGMessageType type;

//是否隐藏时间
@property (nonatomic,assign)BOOL hideTime;

-(instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)messageWithDict:(NSDictionary *)dict;
@end
