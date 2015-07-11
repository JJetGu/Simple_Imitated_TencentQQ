//
//  JGLeftViewController.m
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-7-2.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import "JGLeftViewController.h"
#import "JGChangeThemeViewController.h"

@interface JGLeftViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView *_imageBgV;
    UIImageView *_imageBgV2;
    UIButton *_headButton;
}
@property (nonatomic, strong) NSArray *dataSources;

@end

@implementation JGLeftViewController

-(NSArray *)dataSources
{
    if (!_dataSources) {
        self.dataSources = @[@[@"开通会员", @"vip_shadow.png"],
                         @[@"QQ钱包", @"sidebar_purse.png"],
                         @[@"网上营业厅", @"sidebar_business.png"],
                         @[@"个性装饰", @"sidebar_decoration.png"],
                         @[@"我的收藏", @"sidebar_favorit.png"],
                         @[@"我的相册", @"sidebar_album.png"],
                         @[@"我的文件", @"sidebar_file.png"]];
    }
    return _dataSources;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
     [self.view setBackgroundColor:[UIColor clearColor]];
    
    /**
     *  设置背景
     */
    [self setupBackgroundView];
    
    /**
     *  初始化tableView
     */
    [self setupTableView];
    
    //添加监听
    [self addObserver];
}

/**
 *  设置背景
 */
-(void)setupBackgroundView
{
    //头部背景
    float hHeight = 90;
    UIImageView *imageBgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height/4 + 10)];
    _imageBgV = imageBgV;
    [self.view addSubview:imageBgV];
    
    //下半部分背景
    hHeight = imageBgV.bottom - 80;
    UIImageView *imageBgV2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, hHeight, self.view.width, self.view.height - hHeight)];
    [imageBgV2 setBackgroundColor:[UIColor clearColor]];
    _imageBgV2 = imageBgV2;
    [self.view addSubview:imageBgV2];

    [self reloadImage];
}


-(void)reloadImage
{
    [super reloadImage];
    
    _imageBgV.image = [JGCommonUtil imageWithConfigureNamed:@"sidebar_bg.jpg"];
    
    UIImage *image = [JGCommonUtil imageWithConfigureNamed:@"sidebar_bg_mask.png"];
    [_imageBgV2 setImage:[image stretchableImageWithLeftCapWidth:0 topCapHeight:image.size.height]];
    
    UIImage *headimage = [JGCommonUtil imageWithConfigureNamed:@"chat_bottom_smile_nor.png"];
    [_headButton setBackgroundImage:headimage forState:UIControlStateNormal];
}


/**
 *  初始化tableView
 */
-(void)setupTableView
{
    UITableView *tableview = [[UITableView alloc] init];
    self.tableview = tableview;
    tableview.frame = self.view.bounds;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSources count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
    }

    NSArray *ar = [self.dataSources objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[ar objectAtIndex:1]];
    cell.textLabel.text = [ar objectAtIndex:0];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //关闭左侧抽屉
    AppDelegate *tempAppDelegate = globalAppDelegate;
    [tempAppDelegate.LeftSlideVC closeLeftView];
    
    //跳转到个性装扮页面
    if (indexPath.row == 3) {
        JGChangeThemeViewController *vc = [[JGChangeThemeViewController alloc] init];
        [tempAppDelegate.tabBarVC.currentNavController pushViewController:vc animated:NO];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 160;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.bounds.size.width, 160)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *headButton = [[UIButton alloc] init];
    UIImage *image = [JGCommonUtil imageWithConfigureNamed:@"chat_bottom_smile_nor.png"];
    [headButton setBackgroundImage:image forState:UIControlStateNormal];
    headButton.frame = (CGRect){{20,60},{60,60}};
    _headButton = headButton;
    [view addSubview:headButton];
    
    return view;
}

@end
