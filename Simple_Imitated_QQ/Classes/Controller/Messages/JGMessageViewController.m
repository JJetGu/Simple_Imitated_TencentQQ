//
//  JGMessageViewController.m
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-7-2.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import "JGMessageViewController.h"
#import "JGDropDownMenu.h"

@interface JGMessageViewController ()<JGDropDownMenuDelegate>
{
    UIView *_maskView;
}

@property (nonatomic, strong)NSArray *menuContentArray;

/* 下拉菜单 */
@property (nonatomic, strong)JGDropDownMenu *dropMenu;
@end

@implementation JGMessageViewController

-(NSArray *)menuContentArray
{
    if (!_menuContentArray) {
        self.menuContentArray = @[@[@"建讨论组", @"menu_icon_createDiscuss.png"],
                                  @[@"多人通话", @"menu_icon_groupaudio.png"],
                                  @[@"共享照片", @"menu_icon_camera.png"],
                                  @[@"扫一扫", @"menu_icon_QR.png"]];
    }
    return _menuContentArray;
}

-(JGDropDownMenu *)dropMenu
{
    if (!_dropMenu) {
        self.dropMenu = [[JGDropDownMenu alloc]initWithFrame:CGRectMake(0, -75, self.view.width, 75) contentArray:self.menuContentArray backgroundImageName:@"menu_bg_pressed.png"];
        self.dropMenu.delegate = self;
    }
    
    return _dropMenu;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //JGLog(@"1-----viewWillAppear");
    
    //打开滑动手势
    AppDelegate *tempAppDelegate = globalAppDelegate;
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
    
    //页面呈现时隐藏下拉菜单
    UIButton *rightBtn = (UIButton *)self.navigationItem.rightBarButtonItem.customView;
    if (rightBtn.selected) {
        [self dismissMenu];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加监听
    [self addObserver];
    
    //加载图片
    [self reloadImage];
}

-(void)reloadImage
{
    [super reloadImage];
    
    /* 设置导航栏上面的内容 */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(showLeftView) image:@"navigationbar_friendsearch.png" highImage:@"navigationbar_friendsearch_highlighted.png"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(showMenu:) image:@"menu_icon_bulb.png" selectedImage:@"menu_icon_bulb_pressed.png"];
}

/**
 *  显示侧边栏
 */
- (void)showLeftView
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}

/**
 *  下拉菜单
 */
- (void)showMenu:(UIButton *)btn
{
    [btn setUserInteractionEnabled:NO];
    [btn setSelected:!btn.selected];
    
    [self showMenuWithBool:btn.selected complete:^()
     {
         [btn setUserInteractionEnabled:YES];
     }];
}

- (void)showMenuWithBool:(BOOL)bShow complete:(void(^)())complete
{
    if (bShow)
    {
        [self createMenu];
        
        [UIView animateWithDuration:0.3 animations:^
         {
             self.dropMenu.y = 0;
         } completion:^(BOOL finished)
         {
             complete();
         }];
    }else
    {
        [UIView animateWithDuration:0.3 animations:^
         {
             self.dropMenu.y = -self.dropMenu.height;
         } completion:^(BOOL finished)
         {
             [_maskView removeFromSuperview];
             complete();
         }];
    }
}

//创建下拉菜单
-(void)createMenu
{
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height  - self.tabBarController.tabBar.height)];
    [maskView setClipsToBounds:YES];
    _maskView = maskView;
    [self.view addSubview:maskView];
    
    UIView *bg = [[UIView alloc] initWithFrame:maskView.bounds];
    [bg setBackgroundColor:[UIColor blackColor]];
    [bg setAlpha:0.3];
    [maskView addSubview:bg];
    
    UITapGestureRecognizer *tSM = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMenuByTap:)];
    [bg addGestureRecognizer:tSM];
    
    [maskView addSubview:self.dropMenu];
}

-(void)dismissMenu
{
    UIButton *rightBtn = (UIButton *)self.navigationItem.rightBarButtonItem.customView;
    [rightBtn setUserInteractionEnabled:NO];
    [rightBtn setSelected:!rightBtn.selected];
    [self showMenuWithBool:rightBtn.selected complete:^()
     {
         [rightBtn setUserInteractionEnabled:YES];
     }];
}
/**
 * 菜单背景单击手势
 */
- (void)showMenuByTap:(UITapGestureRecognizer *)tap
{
    [self dismissMenu];
}

#pragma  mark - JGDropDownMenuDelegate
-(void)dropDownMenu:(JGDropDownMenu *)dropDownMenu pressAtIndex:(NSInteger)index
{
    [self dismissMenu];
    JGLog(@"%ld",(long)index);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
