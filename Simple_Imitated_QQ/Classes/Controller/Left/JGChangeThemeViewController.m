//
//  JGChangeThemeViewController.m
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-7-3.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import "JGChangeThemeViewController.h"
#import "JGWaterflowView.h"
#import "JGThemeCell.h"
#import "MJRefresh.h"

@interface JGChangeThemeViewController ()<JGWaterflowViewDataSource, JGWaterflowViewDelegate>

@property (nonatomic, strong)NSArray *themes;
@property (nonatomic, weak) JGWaterflowView *waterflowView;

@end

@implementation JGChangeThemeViewController

- (NSArray *)themes
{
    if (!_themes) {
        self.themes = @[@[@"默认", @"", @"theme_default.png"],
                        @[@"海洋", @"com.skin.1110", @"theme_sea.png"],
                        @[@"外星人", @"com.skin.1114", @"theme_universe.png"],
                        @[@"小黄鸭", @"com.skin.1108", @"theme_yellowduck.png"],
                        @[@"企鹅", @"com.skin.1098", @"theme_penguin.png"]];
    }
    return _themes;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //NSLog(@"3----viewWillAppear");
    AppDelegate *tempAppDelegate = globalAppDelegate;
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个性装扮";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"我的装扮" style:0 target:self action:@selector(myDressUp)];
    
    //初始化瀑布流
    JGWaterflowView *waterflowView = [[JGWaterflowView alloc]init];
    waterflowView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    waterflowView.frame = self.view.bounds;
    waterflowView.dataSource = self;
    waterflowView.delegate = self;
    [self.view addSubview:waterflowView];
    _waterflowView = waterflowView;
    
    // 2.继承刷新控件
    __weak UIScrollView *wfView = self.waterflowView;
    
    // 下拉刷新
    wfView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        //这里只是做一个模拟刷新---------------------
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新瀑布流控件
            [self.waterflowView reloadData];
            
            //停止刷新
            [self.waterflowView.header endRefreshing];
        });
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    wfView.header.autoChangeAlpha = YES;
    
    // 上拉刷新
    wfView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       
        //这里只是做一个模拟刷新---------------------
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新瀑布流控件
            [self.waterflowView reloadData];
            
            //停止刷新
            [self.waterflowView.footer endRefreshing];
        });
    }];

}

/*
 * 我的装扮
 */
- (void)myDressUp
{
    
}

#pragma mark - 数据源方法
-(NSUInteger)numberOfCellsInWaterflowView:(JGWaterflowView *)waterflowView
{
    return self.themes.count;
}

-(JGWaterflowViewCell *)waterflowView:(JGWaterflowView *)waterflowView cellAtIndex:(NSUInteger)index
{
    JGThemeCell *cell = [JGThemeCell cellWithWaterflowView:waterflowView];
    
    [cell themeSourcesArray:self.themes[index] atIndex:index];
    
    return cell;
}

#pragma mark - 代理方法
-(CGFloat)waterflowView:(JGWaterflowView *)waterflowView heightAtIndex:(NSUInteger)index
{
    switch (index % 3) {
        case 0: return 110;
        case 1: return 120;
        case 2: return 100;
        default: return 110;
    }
}

-(void)waterflowView:(JGWaterflowView *)waterflowView didSelectAtIndex:(NSUInteger)index
{
    NSLog(@"点击了第%lu个cell", (unsigned long)index);
    
    NSArray *arr = [self.themes objectAtIndex:index];
    //存入系统标号
    [JGUserDefaults defaultConfigure].themeIndex = index;
    [JGUserDefaults defaultConfigure].themefold = [arr objectAtIndex:1];
    
   // JGLog(@"%@",[JGUserDefaults defaultConfigure].themefold);
    
    //刷新表格
    [self.waterflowView reloadData];
    
    if ([arr objectAtIndex:1] != nil && ((NSString *)[arr objectAtIndex:1]).length > 0)
    {
        //解压主题
        [JGCommonUtil unzipFileToDocumentWithFileName:[arr objectAtIndex:1]];
    }
    
    //发送通知更改主题
    [JGNotificationCenter postNotificationName:CHANGEAPPTHEME object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
