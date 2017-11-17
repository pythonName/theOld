//
//  GuardiansTableViewCell.m
//  theOld
//
//  Created by 张欢欢 on 2017/11/9.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "GuardiansTableViewCell.h"

@implementation GuardiansTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.personImageV.image = [UIImage imageNamed:@"accountIconDefault.png"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
