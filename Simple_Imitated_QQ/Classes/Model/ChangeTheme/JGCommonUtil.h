//
//  JGCommonUtil.h
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-7-6.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGCommonUtil : NSObject

/**
 *  根据文件名字解压到文件夹
 *
 *  @param fileName 传入的文件名
 */
+ (void)unzipFileToDocumentWithFileName:(NSString *)fileName;

/**
 *  将文件移动到对应的文件夹
 *
 *  @param fileName 传入的文件名
 *  @param fileType 文件类型
 */
+ (void)moveFileToDocument:(NSString *)fileName type:(NSString *)fileType;


+ (UIImage *)imageWithConfigureNamed:(NSString *)name;

@end
