//
//  JYPageViewController.m
//  ddd
//
//  Created by 应明顺 on 17/5/24.
//  Copyright © 2017年 CSII. All rights reserved.
//

#import "JYPageViewController.h"
#import "JYPageCollectionView.h"

@interface JYPageViewController ()

@end

@implementation JYPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *dataSource = [NSMutableArray array];
    for (int i = 0; i < 101; i++) {
        NSDictionary *param = @{@"key": @(i)};
        [dataSource addObject:param];
    }
    JYPageCollectionView *page = [[JYPageCollectionView alloc] initWithFrame:self.view.bounds];
    page.dataSource = dataSource;
    page.rowCount = 8;
    page.itemCountPerRow = 10;
    [self.view addSubview:page];
        
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
