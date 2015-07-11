//
//  JGDropDownMenu.m
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15-7-3.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import "JGDropDownMenu.h"
#import "JGMenuButton.h"

@interface JGDropDownMenu ()
{
    NSArray *_contentArray;
}
@end

@implementation JGDropDownMenu

- (id)initWithFrame:(CGRect)frame contentArray:(NSArray *)array  backgroundImageName:(NSString *)imageName
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        //背景图
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        [imageView setImage:[JGCommonUtil imageWithConfigureNamed:imageName]];
        [self addSubview:imageView];
        
        [self createContentViewWithArray:array];
    }
    return self;
}

- (void)createContentViewWithArray:(NSArray *)contentArray
{
    _contentArray = contentArray;
    
    //设置内容
    [contentArray enumerateObjectsUsingBlock:^(NSArray *array, NSUInteger index, BOOL *stop)
     {
//         NSLog(@"%f",self.width);
//         NSLog(@"%lu",(unsigned long)contentArray.count);
         CGFloat buttonW = self.width / contentArray.count;
         CGFloat buttonH = self.height;
         CGFloat buttonX = buttonW * index;
         CGFloat buttonY = 0;
         
         JGMenuButton *button = [[JGMenuButton alloc]init];
         button.userInteractionEnabled = NO;
         button.contentArray = array;
         button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
         [self addSubview:button];
         
     }];
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocatin = [touch locationInView:self];
    
    float nW = self.width/_contentArray.count;
    int index = touchLocatin.x/nW;
    
    if ([self.delegate respondsToSelector:@selector(dropDownMenu:pressAtIndex:)])
    {
        [self.delegate dropDownMenu:self pressAtIndex:index];
    }

}


@end
