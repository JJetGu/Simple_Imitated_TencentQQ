//
//  JGCommonUtil.m
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-7-6.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import "JGCommonUtil.h"
#import "ZipArchive.h"

@implementation JGCommonUtil

+(void)unzipFileToDocumentWithFileName:(NSString *)fileName
{
    [JGCommonUtil moveFileToDocument:fileName type:@"zip"];
}

+(void)moveFileToDocument:(NSString *)fileName type:(NSString *)fileType
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath2 = [documentsDirectory stringByAppendingPathComponent:[fileName stringByAppendingPathExtension:fileType]];
    NSString *pathFold = [filePath2 stringByDeletingPathExtension];
    NSString *path = [filePath2 stringByDeletingLastPathComponent];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:pathFold])
    {
        //判断是否移动成功，这里文件不能是存在的
        NSError *thiserror = nil;
        if ([[NSFileManager defaultManager] copyItemAtPath:filePath toPath:filePath2 error:&thiserror] != YES)
        {
            NSLog(@"move fail...");
            NSLog(@"Unable to move file: %@", [thiserror localizedDescription]);
        }
        
        ZipArchive *archive = [[ZipArchive alloc] init];
        //1
        if ([archive UnzipOpenFile:filePath2])
        {
            // 2
            BOOL ret = [archive UnzipFileTo:path overWrite: YES];
            if (NO == ret)
            {
                NSLog(@"fail");
            }
            [archive UnzipCloseFile];
        }
        
        [manager removeItemAtPath:filePath2 error:nil];
    }else
    {
        //        [manager removeItemAtPath:filePath2 error:nil];
    }
}

+(UIImage *)imageWithConfigureNamed:(NSString *)name
{
    //JGLog(@"%@",name);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    UIImage *image = nil;
    if ([JGUserDefaults defaultConfigure].themefold !=nil && [JGUserDefaults defaultConfigure].themefold.length > 0) {
        NSString *path = [[documentsDirectory stringByAppendingPathComponent:[JGUserDefaults defaultConfigure].themefold] stringByAppendingPathComponent:name];
        
       // JGLog(@"%@",path);
        image = [UIImage imageWithContentsOfFile:path];
    }
    
    if (image ==nil) {
        image = [UIImage imageNamed:name];
    }
    
    return image;
}

@end
