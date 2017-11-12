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
    //价格背景
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(18*ScreenHRatioBaseIphone6, 15, 150, 150)];
    [redView jm_setCornerRadius:10.0 withBackgroundColor:[UIColor redColor]];
    [self.contentView addSubview:redView];
    
    //价格lab
    UILabel *priceLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(redView.frame), CGRectGetHeight(redView.frame))];
    [redView addSubview:priceLab];
    priceLab.text = @"600元";
    priceLab.textColor = [UIColor whiteColor];
    
    //757
    UIView *whiterView  = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(redView.frame), 15, ScreenWidth-CGRectGetMaxX(redView.frame)-15, 150)];
    whiterView.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:whiterView];
    
    //现金券
   UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, CGRectGetWidth(whiterView.frame), 25)];
    [whiterView addSubview:nameLab];
    nameLab.text = @"现金券";
  
//    nameLab.textColor = [UIColor whiteColor];
    nameLab.font = [UIFont systemFontOfSize:22];
    
    //兑换日期
    UILabel *changeDateLab = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetHeight(whiterView.frame)/2-10, CGRectGetWidth(whiterView.frame), 20)];
    [whiterView addSubview:changeDateLab];
    changeDateLab.text = @"兑换日期：2099-09-09";
    
    changeDateLab.textColor = UIColorFromRGB(0x666666);
    changeDateLab.font = [UIFont systemFontOfSize:16];
    //有效日期
    UILabel *effectiveDateLab = [[UILabel alloc] initWithFrame:CGRectMake(15,  CGRectGetHeight(whiterView.frame)/2+30, CGRectGetWidth(whiterView.frame), 20)];
    [whiterView addSubview:effectiveDateLab];
    effectiveDateLab.text = @"有效日期：2099-09-09";
 
    effectiveDateLab.textColor = UIColorFromRGB(0x666666);
    effectiveDateLab.font = [UIFont systemFontOfSize:16];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
