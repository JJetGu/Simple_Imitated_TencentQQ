//
//  JGChatViewController.m
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-7-7.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import "JGChatViewController.h"
#import "JGMessageCell.h"
#import "JGMessageFrame.h"
#import "JGMessage.h"

@interface JGChatViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

//消息数组
@property (nonatomic, strong) NSMutableArray *messages;
//自动回复的消息数组
@property (nonatomic, strong) NSDictionary *autoReplay;

@property (weak, nonatomic) IBOutlet UITextField *inputView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation JGChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Chat";
    
    self.tableView.allowsSelection = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.inputView.delegate = self;
    //设置inputView的leftView
    self.inputView.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
    self.inputView.leftViewMode = UITextFieldViewModeAlways;
    
    //添加键盘改变通知监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

/**
 *  聊天消息内容
 */
-(NSMutableArray *)messages
{
    if (!_messages) {
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil]];
        
        NSMutableArray *mutArray = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            JGMessage *messageModel = [JGMessage messageWithDict:dict];
            
            //时间比较--时间相同，不显示时间
            JGMessageFrame *last = [mutArray lastObject];
            //隐藏时间
            messageModel.hideTime = [messageModel.time isEqualToString:last.message.time];
            
            //将模型数据存入字典
            JGMessageFrame *messageFrame = [[JGMessageFrame alloc]init];
            messageFrame.message = messageModel;
            
            [mutArray addObject:messageFrame];
        }
        self.messages = mutArray;
    }
    
    return _messages;
}

/**
 *  自动回复消息内容
 */
-(NSDictionary *)autoReplay
{
    if (!_autoReplay) {
        self.autoReplay = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"autoReplay.plist" ofType:nil]];
    }
    
    return _autoReplay;
}

#pragma mark - UITextFiledDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
   // JGLog(@"%@",textField.text);
    
    //发动一条消息
    [self sendAMessageWithText:textField.text andType:JGMessageTypeGatsby];
    
    //自动回复一条消息
    NSString *autoStr = [self autoReceiveAMessageWithText:textField.text];
    //将自动回复的消息添加到聊天记录中
    [self sendAMessageWithText:autoStr andType:JGMessageTypeJobs];
    
    //清空输入框内容
    self.inputView.text = @"";
    
    return YES;
}

/**
 *  发送一条消息
 */
-(void)sendAMessageWithText:(NSString *)text andType:(JGMessageType)type
{
    //添加一条消息
    JGMessage *messageModel = [[JGMessage alloc]init];
    messageModel.time = [self getCurrentTime];
    messageModel.text = text;
    messageModel.type = type;
    
    JGMessageFrame *messageFrame = [[JGMessageFrame alloc]init];
    messageFrame.message = messageModel;
    
    //添加入聊天信息数组中
    [self.messages addObject:messageFrame];
    
    [self.tableView reloadData];
    
    //UITableView滚动到底部
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

/**
 *  自动回复一条消息
 */
-(NSString *)autoReceiveAMessageWithText:(NSString *)text
{
    for (int i = 0; i < text.length; i++) {
        NSString *subStr = [text substringWithRange:NSMakeRange(i, 1)]; // 截出每一个字符
        
        if (self.autoReplay[subStr]) { //有这个键取出这个值
            return  self.autoReplay[subStr];
        }
    }
    
    return @"[自动回复]您好，我现在有事不在，一会再和您联系。";
}

/**
 *  获取系统当前的时间
 */
-(NSString *)getCurrentTime
{
    NSDate* now = [NSDate date];
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.dateStyle = kCFDateFormatterShortStyle;
    fmt.timeStyle = kCFDateFormatterShortStyle;
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    return [fmt stringFromDate:now];
}

#pragma mark - 键盘通知
-(void)keyboardDidChangeFrame:(NSNotification *)noti
{
    self.view.window.backgroundColor = self.tableView.backgroundColor;
    
    //最终键盘的frame
    CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //键盘变化的Y值
    CGFloat keyY = frame.origin.y;
    
    //屏幕的高度
    CGFloat screenH = [[UIScreen mainScreen] bounds].size.height;
    
    //键盘动画时间
    CGFloat keyDuration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:keyDuration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, keyY - screenH);
    }];
    
    //UITableView滚动到底部
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

#pragma mark tableview数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JGMessageFrame *modelFrame = [self.messages objectAtIndex:indexPath.row];
    return modelFrame.cellH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JGMessageCell *cel = [JGMessageCell messageCellWithTableView:tableView];
    
    //设置数据
    JGMessageFrame *modelFrame = self.messages[indexPath.row];
    cel.messageFrame = modelFrame;
    
    return cel;
}

//当tableview 滚动的时候 结束编辑事件  （退出键盘）
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
