//
//  JGUserDefaults.h
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-7-6.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSELECTEDTHEMEINDEX @"selectedThemeIndex"
#define kSELECTEDTHEMEFOLD @"selectedThemeFold"

@interface JGUserDefaults : NSObject

@property (nonatomic, assign) NSInteger themeIndex;
@property (nonatomic, retain) NSString *themefold;

+(JGUserDefaults *)defaultConfigure;

@end
