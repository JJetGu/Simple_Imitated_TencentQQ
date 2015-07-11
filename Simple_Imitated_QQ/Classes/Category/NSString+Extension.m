//
//  NSString+Extension.m
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-7-9.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

-(NSString *)stringByRemovingAllWhitespaceAndNewLine
{
    //去除2端的空格
    NSString *temptext = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //去除回车
    NSString *text = [temptext stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
    
    return text;
}

@end
