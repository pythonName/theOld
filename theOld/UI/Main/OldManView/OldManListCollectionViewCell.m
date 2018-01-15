//
//  OldManListCollectionViewCell.m
//  theOld
//
//  Created by 拓润公司 on 2017/11/8.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "OldManListCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation OldManListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.personImageV.image = [UIImage imageNamed:@"accountIconDefault.png"];
}

- (void)setModel:(CareOldManModel *)model{
    _model = model;
    
    [self updateUI];
}

- (void)updateUI{
    if (_model) {
        _nameLab.text = _model.name;
        if (_model.photo.length > 0) {
            [_personImageV sd_setImageWithURL:[NSURL URLWithString:_model.photo] placeholderImage:[UIImage imageNamed:PLACE_HOLDER_PORTRAIT]];
        }
        else{
            _personImageV.image = [UIImage imageNamed:PLACE_HOLDER_PORTRAIT];
        }
    }
    else{
        _personImageV.image = [UIImage imageNamed:PLACE_HOLDER_PORTRAIT];
    }
}

@end
