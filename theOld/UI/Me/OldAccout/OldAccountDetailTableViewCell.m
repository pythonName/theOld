//
//  OldAccountDetailTableViewCell.m
//  theOld
//
//  Created by 张欢欢 on 2017/11/12.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "OldAccountDetailTableViewCell.h"

@implementation OldAccountDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    [self.renewalBtn jm_setCornerRadius:2 withBackgroundColor:UIColorFromRGB(0xff9c31)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//续费按钮事件
- (IBAction)renewalBtnClick:(id)sender {
}

@end
