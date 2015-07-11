//
//  JGBaseViewController.m
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-7-6.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import "JGBaseViewController.h"

@interface JGBaseViewController ()

@end

@implementation JGBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   // NSLog(@"3----viewWillAppear");
    AppDelegate *tempAppDelegate = globalAppDelegate;
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
}


- (void)addObserver
{
    JGAddObsver(observerReloadImage:, CHANGEAPPTHEME);
}

- (void)dealloc
{
    JGRemoveObsver;
}

- (void)observerReloadImage:(NSNotificationCenter *)notif
{
    [self reloadImage:notif];
}

- (void)reloadImage:(NSNotificationCenter *)notif
{
    [self reloadImage];
}

/**
 *  重新加载图片
 */
-(void)reloadImage
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
