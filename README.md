# JYPageCollectionDemo
分页菜单，横向纵向滚动均为从左向右排列

1. 编写原因:系统的collectionView滑动方向和布局方向相反，如：垂直滑动时，cell的布局从左到右，水平滑动时，cell布局从上到下，
2. 编写目标：无论滑动方向如何布局方向均为从左到右，切具有分页效果，
3. 分页效果：每页单独成页，翻到下一页时，不显示上一页的数据，当最后只有一条数据时，该条数据单独成一页展示
3. 说明：
	1. 视图内容区域（contentSize）高度自适应，最终高度＝行数＊每行高度；
    2. 内部cell的大小为正方形，高宽相等，等于scrollView宽度／每行个数，每个cell的宽度相等；  
    3. 类名含有CollectionView但使用的是View，不使用CollectionView；
    
4. 使用方式：使用方式和普通View使用一致，其他只需设置dataSource、itemCountPerRow、itemCountPerRow 三个属性即可；