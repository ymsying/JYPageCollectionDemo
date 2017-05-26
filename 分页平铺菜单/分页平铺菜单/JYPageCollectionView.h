//
//  JYPageCollectionView.h
//  ddd
//
//  Created by 应明顺 on 17/5/24.
//  Copyright © 2017年 CSII. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * 编写原因:系统的collectionView滑动方向和布局方向相反，如：垂直滑动时，cell的布局从左到右，水平滑动时，cell布局从上到下，
 * 编写目标：无论滑动方向如何布局方向均为从左到右，切具有分页效果，
 * 分页效果：每页单独成页，翻到下一页时，不显示上一页的数据，当最后只有一条数据时，该条数据单独成一页展示
 *
 * 说明：视图高度自适应，最终高度＝行数＊每行高度；
 *      内部cell的大小为正方形，高宽相等，等于scrollView宽度／每行个数，每个cell的宽度相等
 */
// 类名有CollectionView但使用的是View，不使用CollectionView
@interface JYPageCollectionView : UIView

// 先使用横向滑动布局

// 一行中 cell 的个数，根据每行的个数来决定宽度
@property (nonatomic,assign) NSUInteger itemCountPerRow;
/*
 * 一页显示多少行，根据每行数来决定高度
 *  当设置为NSNotFound时，只显示一页
 */
@property (nonatomic,assign) NSUInteger rowCount;

@property (nonatomic, strong) NSArray <NSDictionary *> *dataSource;

@end
