//
//  JGThemeCell.m
//  Simple_Imitated_QQ
//
//  Created by JJetGu on 15/7/4.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import "JGThemeCell.h"
#import "JGWaterflowView.h"

@interface JGThemeCell()

@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UIImageView *selectedImageView;

@end

@implementation JGThemeCell

+(instancetype)cellWithWaterflowView:(JGWaterflowView *)waterflowView
{
    static NSString *ID = @"Theme";
    JGThemeCell *cell = [waterflowView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JGThemeCell alloc] init];
        cell.identifier = ID;
    }
    return cell;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        self.imageView = imageView;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UIImageView *selectedImageView = [[UIImageView alloc] init];
        [self addSubview:selectedImageView];
        UIImage *imageName = [JGCommonUtil imageWithConfigureNamed:@"common_green_checkbox.png"];
        [selectedImageView setImage:imageName];
        self.selectedImageView = selectedImageView;
    }
    return self;
}

- (void)themeSourcesArray:(NSArray *)array selected:(BOOL)bSelected
{
    [self.imageView setImage:[UIImage imageNamed:[array objectAtIndex:2]]];
    self.titleLabel.text = [array objectAtIndex:0];
    [self.selectedImageView setHidden:!bSelected];
}

- (void)themeSourcesArray:(NSArray *)array atIndex:(NSUInteger)index
{
    if ([JGUserDefaults defaultConfigure].themeIndex == index) {
         [self themeSourcesArray:array selected:YES];
    } else {
         [self themeSourcesArray:array selected:NO];
    }
   
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    
    CGFloat priceX = 0;
    CGFloat priceH = 25;
    CGFloat priceY = self.bounds.size.height - priceH;
    CGFloat priceW = self.bounds.size.width;
    self.titleLabel.frame = CGRectMake(priceX, priceY, priceW, priceH);
    
    CGSize imageSize= self.selectedImageView.image.size;
    self.selectedImageView.frame = (CGRect){{self.width - imageSize.width, 0},imageSize};
    
}

@end
