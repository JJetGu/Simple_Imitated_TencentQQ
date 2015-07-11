//
//  JGUserDefaults.m
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-7-6.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import "JGUserDefaults.h"

@implementation JGUserDefaults

/**
 *  单例的实现
 */
+(JGUserDefaults *)defaultConfigure
{
    static JGUserDefaults *configureUserDefaults = nil;
    //只加载一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configureUserDefaults = [[JGUserDefaults alloc]init];
    });
    
    return configureUserDefaults;
}

-(instancetype)init
{
    self = [super init];
    
    //从系统编号中取出对应的值
    self.themeIndex = [[[NSUserDefaults standardUserDefaults] objectForKey:kSELECTEDTHEMEINDEX] integerValue];
    self.themefold = [[NSUserDefaults standardUserDefaults] objectForKey:kSELECTEDTHEMEFOLD];
    
    return self;
}

/**
 *  将主题序号和主题名称存入系统编号
 */
-(void)setThemeIndex:(NSInteger)themeIndex
{
    _themeIndex = themeIndex;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:themeIndex] forKey:kSELECTEDTHEMEINDEX];
}

-(void)setThemefold:(NSString *)themefold
{
    _themefold = themefold;
    [[NSUserDefaults standardUserDefaults] setObject:_themefold forKey:kSELECTEDTHEMEFOLD];
}
@end
