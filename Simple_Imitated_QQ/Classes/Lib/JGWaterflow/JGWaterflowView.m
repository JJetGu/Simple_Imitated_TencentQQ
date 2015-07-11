//
//  JGWaterflowView.m
//  SampleCollectionViewDemo
//
//  Created by JJetGu on 15-6-25.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import "JGWaterflowView.h"
#import "JGWaterflowViewCell.h"

#define JGWaterflowViewDefaultCellH 70
#define JGWaterflowViewDefaultMargin 8
#define JGWaterflowViewDefaultNumberOfColumns 3

@interface JGWaterflowView ()
/**
 *  所有cell的frame数据
 */
@property (nonatomic, strong)NSMutableArray *cellFrames;
/**
 *  正在展示的cell
 */
@property (nonatomic, strong) NSMutableDictionary *displayingCells;
/**
 *  缓存池（用Set，存放离开屏幕的cell）
 */
@property (nonatomic, strong) NSMutableSet *reusableCells;

@end

@implementation JGWaterflowView

#pragma mark - 初始化--懒加载
- (NSMutableArray *)cellFrames
{
    if (_cellFrames == nil) {
        self.cellFrames = [NSMutableArray array];
    }
    return _cellFrames;
}

- (NSMutableDictionary *)displayingCells
{
    if (_displayingCells == nil) {
        self.displayingCells = [NSMutableDictionary dictionary];
    }
    return _displayingCells;
}

- (NSMutableSet *)reusableCells
{
    if (_reusableCells == nil) {
        self.reusableCells = [NSMutableSet set];
    }
    return _reusableCells;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [self reloadData];
}

#pragma mark - 公共接口
/**
 *  cell的宽度
 */
- (CGFloat)cellWidth
{
    NSUInteger numberOfColumns = [self numberOfColumns];
    CGFloat leftM = [self marginForType:JGWaterflowViewMarginTypeLeft];
    CGFloat rightM = [self marginForType:JGWaterflowViewMarginTypeRight];
    CGFloat columnM = [self marginForType:JGWaterflowViewMarginTypeColumn];
    return (self.bounds.size.width - leftM - rightM - (numberOfColumns - 1) * columnM) / numberOfColumns;
}

/**
 *  刷新数据
 *  1.计算每一个cell的frame 和 contentSize
 */
-(void)reloadData
{
    // 清空之前的所有数据
    // 移除正在正在显示cell
    [self.displayingCells.allValues makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.displayingCells removeAllObjects];
    [self.cellFrames removeAllObjects];
    [self.reusableCells removeAllObjects];
    
    
    //cell的总数
    NSUInteger numberOfCells = [self.dataSource numberOfCellsInWaterflowView:self];
    
    //总列数
    NSUInteger numberOfColumns = [self numberOfColumns];
    
    //间距
    CGFloat topM = [self marginForType:JGWaterflowViewMarginTypeTop];
    CGFloat bottomM = [self marginForType:JGWaterflowViewMarginTypeBottom];
    CGFloat leftM = [self marginForType:JGWaterflowViewMarginTypeLeft];
    
    CGFloat columnM = [self marginForType:JGWaterflowViewMarginTypeColumn];
    CGFloat rowM = [self marginForType:JGWaterflowViewMarginTypeRow];
    
    // cell的宽度
    CGFloat cellW = [self cellWidth];
    
    // 用一个C语言数组存放所有列的最大Y值 @[0.0, 0.0, 0.0]  初始化
    CGFloat maxYOfColumns[numberOfColumns];
    for (int i = 0; i < numberOfColumns; i++) {
        maxYOfColumns[i] = 0.0;
    }
    
    for (int i = 0; i < numberOfCells; i++) {
        // cell处在第几列(最短的一列)
        NSUInteger cellColumn = 0;
        // cell所处那列的最大Y值(最短那一列的最大Y值)
        CGFloat maxYOfCellColumn = maxYOfColumns[cellColumn];
        
        //求出最短的一列和最短一列的Y值
        for (int j = 1; j < numberOfColumns; j++) {
            if (maxYOfColumns[j] < maxYOfCellColumn) {
                cellColumn = j;
                maxYOfCellColumn = maxYOfColumns[j];
            }
        }
        
        // 询问代理i位置的高度
        CGFloat cellH = [self heightAtIndex:i];
        
        //cell的位置
        CGFloat cellX = leftM + cellColumn *(cellW + columnM);
        CGFloat cellY = 0;
        if (maxYOfCellColumn == 0.0) { //第一行
            cellY = topM;
        } else {
            cellY = maxYOfCellColumn + rowM;
        }
        
        // 添加frame到数组中
        CGRect cellFrame = CGRectMake(cellX, cellY, cellW, cellH);
        [self.cellFrames addObject:[NSValue valueWithCGRect:cellFrame]];
        
        //更新最短那一列的最大Y值
        maxYOfColumns[cellColumn] = CGRectGetMaxY(cellFrame);
    }
    
    //设置contentSize
    CGFloat contentH = maxYOfColumns[0];
    for (int i = 1; i< numberOfColumns; i++) {
        if (maxYOfColumns[i] > contentH) {
            contentH = maxYOfColumns[i];
        }
    }
    contentH +=bottomM;
    self.contentSize = CGSizeMake(0, contentH);
}

/**
 *  当UIScrollView滚动的时候也会调用这个方法    重用机制
 */
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 向数据源索要对应位置的cell
    NSUInteger numberOfCells = self.cellFrames.count;
    for (int i =  0; i < numberOfCells; i++) {
        //取出i位置的frame
        CGRect cellFrame = [self.cellFrames[i] CGRectValue];
        
        // 优先从字典中取出i位置的cell
        JGWaterflowViewCell *cell = self.displayingCells[@(i)];
        
        // 判断i位置对应的frame在不在屏幕上（能否看见）
        if ([self isInScreen:cellFrame]) { // 在屏幕上
            if (cell == nil) {
                cell = [self.dataSource waterflowView:self cellAtIndex:i];
                cell.frame = cellFrame;
                [self addSubview:cell];
                
                // 存放到字典中
                self.displayingCells[@(i)] = cell;
            }
        } else { // 不在屏幕上
            if (cell) {
                [cell removeFromSuperview];
                [self.displayingCells removeObjectForKey:@(i)];
                
                // 存放进缓存池
                [self.reusableCells addObject:cell];
            }
        }
    }
}

-(id)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    __block JGWaterflowViewCell *reusabbleCell = nil;
    [self.reusableCells enumerateObjectsUsingBlock:^(JGWaterflowViewCell *cell, BOOL *stop) {
        if ([cell.identifier isEqualToString:identifier]) {
            reusabbleCell = cell;
            *stop = YES;
        }
    }];
    
    if (reusabbleCell) { // 从缓存池中移除---因为他已经使用了，就就加不进去，frame就无法改变
        [self.reusableCells removeObject:reusabbleCell];
    }
    
    return  reusabbleCell;
}

#pragma mark - 私有方法
/**
 *  判断一个frame有无显示在屏幕上
 */
-(BOOL)isInScreen:(CGRect)frame
{
    return (CGRectGetMaxY(frame) > self.contentOffset.y) && (CGRectGetMinY(frame) < self.contentOffset.y + self.bounds.size.height);
}

/**
 *  总列数
 */
- (NSUInteger)numberOfColumns
{
    if ([self.dataSource respondsToSelector:@selector(numberOfColumnsInWaterflowView:)]) {
        return  [self.dataSource numberOfColumnsInWaterflowView:self];
    } else {
        return JGWaterflowViewDefaultNumberOfColumns;
    }
}

/**
 *  间距
 */
-(CGFloat)marginForType:(JGWaterflowViewMarginType)type
{
    if ([self.delegate respondsToSelector:@selector(waterflowView:marginForType:)]) {
        return [self.delegate waterflowView:self marginForType:type];
    } else {
        return JGWaterflowViewDefaultMargin;
    }
}

/**
 *  index位置对应的高度
 */
-(CGFloat)heightAtIndex:(NSUInteger)index
{
    if ([self.delegate respondsToSelector:@selector(waterflowView:heightAtIndex:)]) {
        return [self.delegate waterflowView:self heightAtIndex:index];
    } else {
        return JGWaterflowViewDefaultCellH;
    }
}

#pragma mark - 事件处理
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![self.delegate respondsToSelector:@selector(waterflowView:didSelectAtIndex:)]) {
        return;
    }
    
    // 获得触摸点
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    __block NSNumber *selectIndex = nil;
    [self.displayingCells enumerateKeysAndObjectsUsingBlock:^(id key, JGWaterflowViewCell *cell, BOOL *stop) {
        if (CGRectContainsPoint(cell.frame, point)) {
            selectIndex = key;
            *stop = YES;
        }
    }];
    
    if (selectIndex) {
        [self.delegate waterflowView:self didSelectAtIndex:selectIndex.unsignedIntegerValue];
    }
}

@end
