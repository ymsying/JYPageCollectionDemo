//
//  JYPageCell.m
//  ddd
//
//  Created by 应明顺 on 17/5/24.
//  Copyright © 2017年 CSII. All rights reserved.
//

#import "JYPageCell.h"

@interface JYPageCell ()

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *icon;

@end

@implementation JYPageCell

- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] initWithFrame:self.bounds];
        _icon.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_icon];
    }
    return _icon;
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:self.bounds];
        [self addSubview:_title];
    }
    return _title;
}

- (void)setParams:(NSDictionary *)params {
    self.icon.image = [UIImage imageNamed:@"Tuzki"];
    self.title.text = [NSString stringWithFormat:@"%@", params[@"key"]];
}

@end
