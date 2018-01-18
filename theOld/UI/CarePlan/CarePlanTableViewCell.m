//
//  CarePlanTableViewCell.m
//  theOld
//
//  Created by 张欢欢 on 2017/11/20.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "CarePlanTableViewCell.h"

@implementation CarePlanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(CarePlanModel *)model{
    _model = model;
    
    [self updateUI];
}

- (void)updateUI{
    _nameLab.text = _model.content;
    _timeLab.text = [NSString stringWithFormat:@"%@ - %@",_model.start_time,_model.end_time];
}

@end
