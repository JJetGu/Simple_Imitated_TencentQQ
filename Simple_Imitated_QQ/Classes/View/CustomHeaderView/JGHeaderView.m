//
//  JGHeaderView.m
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-7-10.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import "JGHeaderView.h"
#import "JGFriendsGroup.h"

@interface JGHeaderView ()

@property (nonatomic, strong) UIButton *nameBtn;
@property (nonatomic, weak)UILabel *countLabel;

@end

@implementation JGHeaderView

+(instancetype)headerViewWith:(UITableView *)tableView
{
    static NSString *ID = @"header";
    JGHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
   // if (header ==nil) {
        header = [[JGHeaderView alloc]initWithReuseIdentifier:ID];
        header.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"buddy_header_nor"]];
  //  }
    
    return header;
}

//  当headerview 上子控件只需做一次操作的或者要显示出来的，就写在以下方法中
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[JGCommonUtil imageWithConfigureNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        [btn.titleLabel setFont:headerViewFont];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        //居中显示
        btn.imageView.contentMode = UIViewContentModeCenter;
        //不予许剪切超出部分
        btn.imageView.clipsToBounds = NO;
        [btn addTarget:self action:@selector(nameBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        self.nameBtn = btn;
        
        UILabel *lable = [[UILabel alloc]init];
        [lable setFont:headerViewFont];
        lable.textAlignment = NSTextAlignmentRight;
        [self addSubview:lable];
        self.countLabel = lable;
    }
    
    return self;
}

-(void)setFriendGroup:(JGFriendsGroup *)friendGroup
{
    _friendGroup = friendGroup;
    
    [self.nameBtn setTitle:friendGroup.name forState:UIControlStateNormal];
    
    //在线人数和总人数显示
    self.countLabel.text = [NSString stringWithFormat:@"%ld/%lu",(long)friendGroup.online,(unsigned long)friendGroup.friends.count];
}

/**
 *  点击headerView
 */
- (void)nameBtnClick
{
    self.friendGroup.open = !self.friendGroup.open;
    
    //刷新tableView
    if (self.block) {
        self.block(self);
    }
}

/**
 * 当前的view 加载到父控件的时候调用
 */
- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    if (self.friendGroup.open) {
        self.nameBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    } else {
        self.nameBtn.imageView.transform = CGAffineTransformMakeRotation(0);
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.nameBtn.frame = self.bounds;
    
    CGFloat lblY = 0;
    CGFloat lblW = 150;
    CGFloat lblh = self.frame.size.height;
    CGFloat lblX = self.frame.size.width - lblW - 10;
    
    self.countLabel.frame = CGRectMake(lblX, lblY, lblW, lblh);
    
}

@end
