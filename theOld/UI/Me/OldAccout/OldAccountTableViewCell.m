//
//  OldAccountTableViewCell.m
//  theOld
//
//  Created by 张欢欢 on 2017/11/12.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "OldAccountTableViewCell.h"

@implementation OldAccountTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iconImageV.image = [UIImage imageNamed:@"accountIconDefault.png"];
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
