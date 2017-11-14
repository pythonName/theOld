//
//  MyAccountTableViewCell.m
//  theOld
//
//  Created by 张欢欢 on 2017/11/12.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "MyAccountTableViewCell.h"

@implementation MyAccountTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI {
    
   self.backgroundColor = UIColorFromRGB(0xF5F8FC);
    //背景图片
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(18*ScreenHRatioBaseIphone6, 7, ScreenWidth-30*ScreenHRatioBaseIphone6, 100*ScreenHRatioBaseIphone6)];
    [self.contentView addSubview:imageV];
    imageV.image = [UIImage imageNamed:@"counponImageNo.png"];
  
    //价格lab
    UILabel *priceLab = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, CGRectGetHeight(imageV.frame), CGRectGetHeight(imageV.frame))];
    [imageV addSubview:priceLab];
    priceLab.text = @"600元";
    priceLab.textAlignment = NSTextAlignmentCenter;
    priceLab.textColor = [UIColor whiteColor];
    
    //现金券
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(100*ScreenHRatioBaseIphone6 +15, 15, CGRectGetWidth(imageV.frame), 25)];
    [imageV addSubview:nameLab];
    nameLab.text = @"现金券";
    nameLab.font = [UIFont systemFontOfSize:15];
    
    //兑换日期
    UILabel *changeDateLab = [[UILabel alloc] initWithFrame:CGRectMake(100*ScreenHRatioBaseIphone6 +15, CGRectGetHeight(imageV.frame)/2-4, CGRectGetWidth(imageV.frame), 20)];
    [imageV addSubview:changeDateLab];
    changeDateLab.text = @"兑换日期：2099-09-09";
    
    changeDateLab.textColor = UIColorFromRGB(0x666666);
    changeDateLab.font = [UIFont systemFontOfSize:11];
    //有效日期
    UILabel *effectiveDateLab = [[UILabel alloc] initWithFrame:CGRectMake(100*ScreenHRatioBaseIphone6 +15,  CGRectGetHeight(imageV.frame)/2+17, CGRectGetWidth(imageV.frame), 20)];
    [imageV addSubview:effectiveDateLab];
    effectiveDateLab.text = @"有效日期：2099-09-09";
 
    effectiveDateLab.textColor = UIColorFromRGB(0x666666);
    effectiveDateLab.font = [UIFont systemFontOfSize:11];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
