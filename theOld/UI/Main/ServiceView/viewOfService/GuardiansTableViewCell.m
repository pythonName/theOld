//
//  GuardiansTableViewCell.m
//  theOld
//
//  Created by 张欢欢 on 2017/11/9.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "GuardiansTableViewCell.h"
#import "ImageViewUtil.h"

@implementation GuardiansTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.personImageV.image = [UIImage imageNamed:@"accountIconDefault.png"];
    self.personImageV.layer.cornerRadius = 40;
    self.personImageV.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(GuardianModel *)model{
    _model = model;
    
    [self updateUI];
}

- (void)updateUI{
    self.nameLab.text = _model.name;
    self.sonLab.text = _model.relation;
    self.telNumberLab.text = _model.username;
    if (_model.photo.length > 0) {
        [ImageViewUtil setImage:self.personImageV imageURL:_model.photo placeholder:PLACE_HOLDER_PORTRAIT];
    }
}


@end
