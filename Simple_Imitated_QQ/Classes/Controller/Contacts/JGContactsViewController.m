//
//  JGContactsViewController.m
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-7-2.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import "JGContactsViewController.h"
#import "JGSearchBar.h"
#import "JGDropDownMenu.h"
#import "JGFriends.h"
#import "JGFriendsGroup.h"
#import "JGHeaderView.h"
#import "JGChatViewController.h"

#define headerTableViewHeigth 130

@interface JGContactsViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate,JGDropDownMenuDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *searchContentArray;
@property (nonatomic, strong) NSMutableArray *searchResultArray;

@property (nonatomic, strong) JGSearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchController;

@property (nonatomic, strong)NSArray *friendsArr;
//菜单栏
@property (nonatomic, strong)JGDropDownMenu *dropMenu;

@end

@implementation JGContactsViewController

/**
 *  搜索结果数组
 */
-(NSMutableArray *)searchContentArray
{
    if (!_searchContentArray) {
        
         NSMutableArray *friendsModelArray = [NSMutableArray array];
        
        for (JGFriendsGroup *friendGroupModel in self.friendsArr) {
            for (JGFriends *friendModel in friendGroupModel.friends) {
                [friendsModelArray addObject:friendModel];
            }
        }
        self.searchContentArray = friendsModelArray;
    }
    
    return _searchContentArray;
}

/**
 *  菜单栏
 */
-(JGDropDownMenu *)dropMenu
{
    if (!_dropMenu) {
        self.dropMenu = [[JGDropDownMenu alloc]initWithFrame:CGRectMake(0, 44, self.view.width, headerTableViewHeigth - 44 - 10) contentArray: @[@[@"人脉圈", @"mulchat_header_icon_circle.png"],
                                                                                                                     @[@"通讯录", @"buddy_header_icon_addressBook.png"],
                                                                                                                     @[@"群组", @"buddy_header_icon_group.png"],
                                                                                                                     @[@"生活服务", @"buddy_header_icon_public.png"]] backgroundImageName:@"buddy_header_nor.png"];
        self.dropMenu.delegate = self;
    }
    
    return _dropMenu;
}

/**
 *  存放朋友列表数据
 */
-(NSArray *)friendsArr
{
    if (!_friendsArr) {
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"friends.plist" ofType:nil]];
        
        NSMutableArray *friendsModelArray = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            JGFriendsGroup *model = [JGFriendsGroup friendsGroupWithDict:dict];
            [friendsModelArray addObject:model];
        }
        self.friendsArr = friendsModelArray;
    }
    
    return _friendsArr;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // NSLog(@"3----viewWillAppear");
    AppDelegate *tempAppDelegate = globalAppDelegate;
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:0 target:self action:@selector(addNewFriend)];
    
    //初始化控件
    [self setupTableView];
    
}

/**
 *  导航栏右边按钮方法
 */
- (void)addNewFriend
{
    
}

/**
 *  实例化UItableView
 */
-(void)setupTableView
{
    self.tableView = [[UITableView alloc]init];
    self.tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UIView *view = [self setuptableHeaderView];
    self.tableView.tableHeaderView = view;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
}

/**
 *  tableHeaderView
 */
-(UIView *)setuptableHeaderView
{
    //背景图片
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.width, headerTableViewHeigth)];
    backgroundView.backgroundColor = IWColor(232, 233, 232);
    
    //搜索框
    JGSearchBar *searchBar = [[JGSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
    UISearchDisplayController *searchController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchBar.delegate = self;
    self.searchBar = searchBar;
    
    searchController.delegate = self;
    searchController.searchResultsDataSource = self;
    searchController.searchResultsDelegate = self;
    searchController.searchResultsTableView.tableFooterView = [[UIView alloc] init];
    
    [backgroundView addSubview:searchBar];
    self.searchController = searchController;
    
    self.searchResultArray = [NSMutableArray array];
    
    //菜单栏
    [backgroundView addSubview:self.dropMenu];
    
    return backgroundView;
}

#pragma mark tableview数据源方法
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.searchController.searchResultsTableView) {
        return 0;
    }
    return 44;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.searchController.searchResultsTableView) {
        return 1;
    }
    return self.friendsArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchController.searchResultsTableView) {
        return self.searchResultArray.count;
    }
    
    JGFriendsGroup *friendModel = self.friendsArr[section];
    return friendModel.open ? friendModel.friends.count : 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.searchController.searchResultsTableView) {
        return nil;
    }
    
    JGHeaderView *header = [JGHeaderView headerViewWith:tableView];
    
    JGFriendsGroup *model = self.friendsArr[section];
    header.friendGroup = model;
    
    //block回调
    //    __block typeof(header) weakHeader = header;
    header.block = ^(id sender) {
        [tableView reloadData];
        
        if (model.open == YES) {
            //UITableView滚动到相应位置
            if (section == self.friendsArr.count - 1) { // 最后一行
                NSIndexPath *path = [NSIndexPath indexPathForRow:model.friends.count -1 inSection:section];
                [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            } else {
                NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:section];
                [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
        }
    };
    
    return header;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"friends";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    
    JGFriends *model = nil;
    if (tableView == self.searchController.searchResultsTableView) {
        model = self.searchResultArray[indexPath.row];
    } else {
        JGFriendsGroup *group = self.friendsArr[indexPath.section];
        model = group.friends[indexPath.row];
    }
    
    cell.textLabel.text = model.name;
    cell.textLabel.textColor = model.vip?[UIColor redColor]:[UIColor blackColor];
    cell.detailTextLabel.text = model.intro;
    cell.imageView.image = [UIImage imageNamed:model.icon];
    cell.imageView.layer.cornerRadius = cell.imageView.image.size.height / 2;
    cell.imageView.layer.masksToBounds = YES;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
    
    JGChatViewController *vc = [[JGChatViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UISearchDisplayDelegate
- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
    //设置取消按钮
    [self.searchBar setCancelButton];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    //搜索
    [self searchWithSearchText:searchText.stringByRemovingAllWhitespaceAndNewLine];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self animationUseInSearchBar];
}

- (void) searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
    [self animationUseInSearchBar];
}

-(void)animationUseInSearchBar
{
    [UIView animateWithDuration:0.0f animations:^{
        [self.searchBar removeFromSuperview];
        self.tableView.tableHeaderView = nil;
    } completion:^(BOOL finished) {
        self.tableView.tableHeaderView = [self setuptableHeaderView];
    }];
}
/**
 *  根据关键字搜索
 */
- (void)searchWithSearchText:(NSString*)searchText {
    //将搜索的结果返回给数组
    self.searchResultArray = [self searchText:searchText];
   // NSLog(@"%@",self.searchResultArray);
    
    //刷新表格
    [self.searchController.searchResultsTableView reloadData];
}

/**
 *  将搜索的结果返回
 *
 *  @param searchText 搜索文字
 *
 *  @return 搜索结果数组
 */
- (NSMutableArray*)searchText:(NSString*)searchText {
    NSMutableArray *searchContentArray = [NSMutableArray array];
    
    if (searchText.length <= 0) {
        return searchContentArray;
    }
    
     NSMutableArray *mutArray = [NSMutableArray array];
    for (JGFriends *model in self.searchContentArray) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
        if ([predicate evaluateWithObject:model.name]) {
            [mutArray addObject:model];
        }
    }

    return mutArray;
}

#pragma mark - JGDropDownMenuDelegate
-(void)dropDownMenu:(JGDropDownMenu *)dropDownMenu pressAtIndex:(NSInteger)index
{
    JGLog(@"%ld",index);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
