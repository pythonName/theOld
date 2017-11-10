//
//  UserCenterTableViewCell.m
//  theOld
//
//  Created by 拓润公司 on 2017/11/10.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "UserCenterTableViewCell.h"

@implementation UserCenterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //    //头像图标
    //    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_frame)-30-40, 13, 40, 40)];
    //    _iconImageView.userInteractionEnabled = YES;
    //    _iconImageView.image = [UIImage imageNamed:@"accountIconDefault.png"];
    //    //账号label
    //    _accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_frame)-30-150, 13, 150, 30)];
    //    _accountLabel.text = @"15817297889";
    //    _accountLabel.textColor = UIColorFromRGB(0x999999);
    //    _accountLabel.textAlignment = NSTextAlignmentRight;
    //    _accountLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14.0];
    //    //更好手机label
    //    _changePhoneNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_frame)-30-150, 13, 150, 30)];
    //    _changePhoneNumLabel.text = @"15817297889";
    //    _changePhoneNumLabel.textColor = UIColorFromRGB(0x999999);
    //    _changePhoneNumLabel.textAlignment = NSTextAlignmentRight;
    //    _changePhoneNumLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14.0];
    //    //实名信息完善与否视图
    //    _factNameView = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_frame)-30-66, 20, 66, 19)];
    //    //_factNameView.backgroundColor = UIColorFromRGB(0xff9c31);
    //    _factNameView.textAlignment = NSTextAlignmentCenter;
    //    _factNameView.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:10.0];
    //    [_factNameView jm_setCornerRadius:CGRectGetHeight(_factNameView.frame)/2 withBackgroundColor:UIColorFromRGB(0xff9c31)];
    //    _factNameView.text = @"未完善";
    //    _factNameView.textColor = UIColorFromRGB(0xffffff);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
