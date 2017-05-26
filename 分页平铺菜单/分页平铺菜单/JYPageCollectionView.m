//
//  JYPageCollectionView.m
//  ddd
//
//  Created by 应明顺 on 17/5/24.
//  Copyright © 2017年 CSII. All rights reserved.
//

#import "JYPageCollectionView.h"
#import "JYPageCell.h"

@interface JYPageCollectionView () <UIScrollViewDelegate> {
    
    CGFloat itemWidth;
    CGFloat itemHeight;
    
}

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation JYPageCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.mainScrollView];
        [self addSubview:self.pageControl];
    }
    return self;
}

- (void)layoutSubviews {
//    self.backgroundColor = [UIColor redColor];
    
    [self reloadData];
}

- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.delegate = self;
    }
    return _mainScrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 15)];
    }
    return _pageControl;
}

- (void)reloadData {
    
    if (!self.dataSource) {
        return;
    }
    [self.mainScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat margin = 5;
    
    // 实际总宽度 ＝ 总宽度－（每行个数 ＋ 1）为总宽度－（每个item的间距＋行首的缩进），实际总宽度／每行个数＝》每个item宽度
    itemWidth = (CGRectGetWidth(self.mainScrollView.frame) - (self.itemCountPerRow * margin + margin)) / self.itemCountPerRow;
    itemHeight = itemWidth - margin;
    
    /* 废弃
     * 过程：
     * 1.计算所需总页数； 2.创建每页的单独视图（single page）； 3.创建单页数据； 4.在单页中进行自左向右的排序；
     * 5.添加单页到scroll上， 6.在单页上点击cell时，根据page和cell在单页中的位置转换cell到scroll中的位置；
     */
    
    /* 优化
     * 1.计算所需总页数； 2.确定每页应该包涵的条数，除最后一页其他均应该满铺，最后一页条数由‘总条数’－‘已使用总和’； 3.在单页中进行操作； 4.在单页中进行自左向右的排序； 5.在单页上； 6.在单页上点击cell时，根据page和cell在单页中的位置转换cell到scroll中的位置；
     */
    
    if (self.rowCount == NSNotFound) {
        self.rowCount = self.dataSource.count / self.itemCountPerRow;
        self.pageControl.hidden = YES;
    }
    
    NSInteger itemTotalCount = self.dataSource.count;
    NSInteger itemCountPerPage = self.rowCount * self.itemCountPerRow;
    // '/'计算可铺满的页数，'％'计算是否还有未能铺满页。％结果为0，说明正好全部铺满，有余数说明未铺满，且余数即为未能铺满页的item条数
    NSInteger pageCount = (itemTotalCount / itemCountPerPage) + (itemTotalCount % itemCountPerPage == 0 ? 0 : 1);
    
    
    // 分页计算
    for (int page = 0; page < pageCount; page++) {
        NSInteger itemCountOfCurrentPage = page < pageCount - 1 ? itemCountPerPage : (itemTotalCount - (pageCount - 1) * itemCountPerPage);
        // 计算每页中的item
        for (int i = 0; i < itemCountOfCurrentPage; i++) {
            
            NSDictionary *params = self.dataSource[i + page * itemCountPerPage];
            // 分页的位置 + 在单页中的位置，即单前item的位置
            // X、Y最后 + 1，目的是第一列第一行距顶部左边为1，itemWidth、itemHeight + 1目的是为行每列增加间距
            CGFloat cellX = page * self.mainScrollView.frame.size.width + (i % self.itemCountPerRow) * (itemWidth + margin) + margin;
            CGFloat cellY =                                               (i / self.itemCountPerRow) * (itemHeight + margin) + margin;
            
            JYPageCell *cell = [[JYPageCell alloc] initWithFrame:CGRectMake(cellX, cellY, itemWidth, itemHeight)];
            cell.params = params;
            //cell.backgroundColor = [UIColor redColor];
            [self.mainScrollView addSubview:cell];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedCell:)];
            [cell addGestureRecognizer:tap];
        }

    }
    
    
    // 设置滚动方向
    CGSize contentSize = self.mainScrollView.contentSize;
    contentSize.width = pageCount * self.mainScrollView.frame.size.width;
    contentSize.height = itemHeight * self.rowCount;
    self.mainScrollView.contentSize = contentSize;
    
    // 设置pageControl
    CGFloat centerY = (self.mainScrollView.contentSize.height) - self.pageControl.frame.size.height - self.mainScrollView.contentOffset.y + margin * self.rowCount;
    self.pageControl.center = CGPointMake(CGRectGetWidth(self.mainScrollView.bounds)/2, centerY);
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = pageCount;
}

- (void)setDataSource:(NSArray *)dataSource {
    if (![_dataSource isEqual:dataSource]) {
        _dataSource = dataSource;
        
        [self setNeedsLayout];
    }
}


- (void)selectedCell:(UITapGestureRecognizer *)gestureRecognizer {
    NSInteger horIndex = gestureRecognizer.view.frame.origin.x / itemWidth; // 横向第几个，从第一页开始计数，不分页码
    NSInteger verIndex = gestureRecognizer.view.frame.origin.y / itemHeight; // 纵向第几个，从顶部开始计数，不分页码
    NSInteger currentPage = horIndex / self.itemCountPerRow;
    horIndex = horIndex - (currentPage * self.itemCountPerRow); // 找出在当前页的横向位置
    NSInteger itemIndex = currentPage * (self.itemCountPerRow * self.rowCount) + horIndex + verIndex * self.itemCountPerRow;
    
    NSLog(@"itemIndex:%zi", itemIndex);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = self.mainScrollView.contentOffset.x;
    NSInteger pageIndex = offsetX / CGRectGetWidth(self.mainScrollView.frame);
    self.pageControl.currentPage = pageIndex;
}


@end
