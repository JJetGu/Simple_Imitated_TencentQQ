//
//  JGDynamicViewController.m
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-7-2.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import "JGDynamicViewController.h"

const static CGFloat JGTopViewH = 350;

@interface JGDynamicViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) UIImageView *topView;

@end

@implementation JGDynamicViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // NSLog(@"3----viewWillAppear");
    AppDelegate *tempAppDelegate = globalAppDelegate;
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:0 target:self action:@selector(more)];
    
    //初始化控件
    [self setupTableViewAndTopView];
}

-(void)more
{

}

/**
 *  实例化UItableView
 */
-(void)setupTableViewAndTopView
{
    //tableView
    self.tableView = [[UITableView alloc]init];
    self.tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height - 64);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    //topView
    // 设置内边距(让cell往下移动一段距离)
    self.tableView.contentInset = UIEdgeInsetsMake(JGTopViewH * 0.5, 0, 0, 0);
    
    UIImageView *topView = [[UIImageView alloc] init];
    topView.image = [UIImage imageNamed:@"usersummary_cover_default_pic"];
    topView.frame = CGRectMake(0, -JGTopViewH, self.view.width, JGTopViewH);
    topView.contentMode = UIViewContentModeScaleAspectFill;
    [self.tableView insertSubview:topView atIndex:0];
    self.topView = topView;
    
}

#pragma mark tableview数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"cell的第%ld行",indexPath.row];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 向下拽了多少距离
    CGFloat down = -(JGTopViewH * 0.5) - scrollView.contentOffset.y;
    if (down < 0) return;
    
    CGRect frame = self.topView.frame;
    frame.size.height = JGTopViewH + down;
    self.topView.frame = frame;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
