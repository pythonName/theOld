//
//  UserCenterTableViewCell.m
//  theOld
//
//  Created by 拓润公司 on 2017/11/10.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "UserCenterTableViewCell.h"
#import "UserManager.h"
#import "ImageViewUtil.h"

@implementation UserCenterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //头像图标
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-35-40, 13, 40, 40)];
    _iconImageView.userInteractionEnabled = YES;
    _iconImageView.layer.cornerRadius = 20;
    _iconImageView.clipsToBounds = YES;
    UserManager *userManager = [UserManager shareInstance];
    if ([UserManager shareInstance].photo.length > 0) {
        
        NSString *imageStr = [NSString stringWithFormat:@"%@%@", TESTHOST, [userManager.photo substringWithRange:NSMakeRange(1, userManager.photo.length - 1)]];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageStr]];
        _iconImageView.image = [[UIImage alloc] initWithData:imageData];
    }
    else{
       _iconImageView.image = [UIImage imageNamed:@"accountIconDefault.png"];
    }
    
    [self.contentView addSubview:_iconImageView];
    
    //箭头图标
//    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-30-40, 13, 40, 40)];
//    _iconImageView.userInteractionEnabled = YES;
//    _iconImageView.image = [UIImage imageNamed:@"accountIconDefault.png"];
//    [self.contentView addSubview:_iconImageView];
    
    //账号label
    self.accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-20-150, 10, 150, 30)];
    _accountLabel.text = [UserManager shareInstance].userName;
    _accountLabel.textColor = UIColorFromRGB(0x999999);
    _accountLabel.textAlignment = NSTextAlignmentRight;
    _accountLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14.0];
    [self.contentView addSubview:_accountLabel];
    
    //        //实名信息完善与否视图
    self.factNameView = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-35-66, 15, 66, 19)];
    //_factNameView.backgroundColor = UIColorFromRGB(0xff9c31);
    _factNameView.textAlignment = NSTextAlignmentCenter;
    _factNameView.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:10.0];
    [_factNameView jm_setCornerRadius:CGRectGetHeight(_factNameView.frame)/2 withBackgroundColor:UIColorFromRGB(0xff9c31)];
    if ([@"yes" isEqualToString:userManager.complete]) {
        _factNameView.text = @"已认证";
    }
    else{
        _factNameView.text = @"未完善";
    }
    _factNameView.textColor = UIColorFromRGB(0xffffff);
    [self.contentView addSubview:_factNameView];
}

-(void)refreshCellViewWithData:(id)data indexPath:(NSIndexPath *)indexPath{
   
    self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    self.factNameView.hidden = YES;
    self.accountLabel.hidden = YES;
    UserManager *userManager = [UserManager shareInstance];
    if (indexPath.row == 0 && indexPath.section ==  0) {
        //头像
         self.iconImageView.hidden = NO;
        if ([UserManager shareInstance].photo.length > 0) {
            
//            NSString *imageStr = [NSString stringWithFormat:@"%@%@", TESTHOST, [userManager.photo substringWithRange:NSMakeRange(1, userManager.photo.length - 1)]];
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:userManager.photo]];
            _iconImageView.image = [[UIImage alloc] initWithData:imageData];
        }
        else{
            _iconImageView.image = [UIImage imageNamed:@"accountIconDefault.png"];
        }
    }else if (indexPath.row == 2 && indexPath.section  == 0){
        //实名信息
        self.factNameView.hidden = NO;
        self.iconImageView.hidden = YES;
    }else{
        if (indexPath.row == 1 && indexPath.section  == 0) {
            //账号
            self.accountLabel.frame = CGRectMake(ScreenWidth-20-150, 10, 150, 30);
             self.accessoryType=UITableViewCellAccessoryNone;
        }else{
            self.accountLabel.frame = CGRectMake(ScreenWidth-35-150, 10, 150, 30);
            self.accountLabel.hidden = YES;
        }
        //其他信息
        self.accountLabel.hidden = NO;
        self.iconImageView.hidden = YES;
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            self.accountLabel.text = nil;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
