//
//  JGWaterflowView.h
//  SampleCollectionViewDemo
//
//  Created by JJetGu on 15-6-25.
//  Copyright (c) 2015年 Free. All rights reserved.
//  使用瀑布流形式展示内容的控件

#import <UIKit/UIKit.h>

typedef enum {
    JGWaterflowViewMarginTypeTop,
    JGWaterflowViewMarginTypeBottom,
    JGWaterflowViewMarginTypeLeft,
    JGWaterflowViewMarginTypeRight,
    
    JGWaterflowViewMarginTypeColumn, // 每一列
    JGWaterflowViewMarginTypeRow, // 每一行
} JGWaterflowViewMarginType;

@class JGWaterflowView, JGWaterflowViewCell;

/**
 *  数据源方法
 */
@protocol JGWaterflowViewDataSource <NSObject>
@required
/**
 *  一共有多少个数据(Cell)
 */
- (NSUInteger)numberOfCellsInWaterflowView:(JGWaterflowView *)waterflowView;
/**
 *  返回index位置对应的cell
 */
-(JGWaterflowViewCell *)waterflowView:(JGWaterflowView *)waterflowView cellAtIndex:(NSUInteger)index;

@optional
/**
 *  一共有多少列
 */
- (NSUInteger)numberOfColumnsInWaterflowView:(JGWaterflowView *)waterflowView;

@end


/**
 *  代理方法
 */
@protocol JGWaterflowViewDelegate <UIScrollViewDelegate>
@optional
/**
 *  第index位置cell对应的高度
 */
- (CGFloat)waterflowView:(JGWaterflowView *)waterflowView heightAtIndex:(NSUInteger)index;
/**
 *  选中第index位置的cell
 */
-(void)waterflowView:(JGWaterflowView *)waterflowView didSelectAtIndex:(NSUInteger)index;
/**
 *  返回间距
 */
- (CGFloat)waterflowView:(JGWaterflowView *)waterflowView marginForType:(JGWaterflowViewMarginType)type;
@end


//////////////////////////////////////
/**
 *  瀑布流控件
 */
@interface JGWaterflowView : UIScrollView
/**
 *  数据源
 */
@property (nonatomic, weak) id<JGWaterflowViewDataSource> dataSource;
/**
 *  代理
 */
@property (nonatomic, weak) id<JGWaterflowViewDelegate> delegate;

/**
 *  刷新数据（调用这个方法，会重新向数据源和代理发送请求，请求数据）
 */
- (void)reloadData;

/**
 *  cell的宽度
 */
- (CGFloat)cellWidth;

/**
 *  根据标识去缓存池查找可循环利用的cell___重用机制的标志符
 */
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;
@end







