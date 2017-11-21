//
//  PhysiologicalDataTableViewHeader.m
//  theOld
//
//  Created by 张欢欢 on 2017/11/9.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "PhysiologicalDataTableViewHeader.h"

@implementation PhysiologicalDataTableViewHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = UIColorRGB(245, 249, 252);
        [self configUI];
    }
    return self;
}

#pragma mark - config UI
- (void)configUI
{
    
    
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0,ScreenWidth-30, 30)];
    _dateLabel.textAlignment = NSTextAlignmentLeft;
    _dateLabel.font = [UIFont systemFontOfSize:11];
    _dateLabel.textColor = UIColorFromRGB(0xaaaaaa);
    [self.contentView addSubview:_dateLabel];
    _dateLabel.text = @"2017年10月12日";
    
}

@end
