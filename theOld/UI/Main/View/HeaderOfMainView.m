//
//  HeaderOfMainView.m
//  theOld
//
//  Created by 拓润公司 on 2017/11/8.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "HeaderOfMainView.h"
#import "UIView+NIB.h"
#import "UserManager.h"
#import "UIImageView+WebCache.h"
@implementation HeaderOfMainView

+ (HeaderOfMainView *)loadHeaderOfMainView{
    HeaderOfMainView *vv = (HeaderOfMainView *)[self loadFromNIB];
    [vv updateUI];
//    if(!vv.model) {
//        vv.nameLab.text = @"请先关注老人";
//        vv.sexImageV.hidden = YES;
//    }else{
//        vv.nameLab.text = @"请先关注老人";
//        vv.sexImageV.hidden = NO;
//    }
    return vv;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.resouseButton.layer.cornerRadius = 10;
    self.headerImageV.layer.cornerRadius = 38;
    self.headerImageV.clipsToBounds = YES;
    
}

//老人资料卡
- (IBAction)gotoResouseButtonClick:(id)sender {
    
}

- (void)setModel:(CareOldManModel *)model{
    _model = model;
    
    [self updateUI];
}

- (void)updateUI{
    if (_model) {
        _sexImageV.hidden = NO;
        if ([_model.sex isEqualToString:@"男"]) {
            _sexImageV.image = [UIImage imageNamed:@"man.png"];
        }
        else{
            _sexImageV.image = [UIImage imageNamed:@"women.png"];
        }
        self.nameLab.text = [NSString stringWithFormat:@"%@  %ld岁", _model.name, _model.age];
        
        if (_model.photo.length > 0) {
            [_headerImageV sd_setImageWithURL:[NSURL URLWithString:_model.photo] placeholderImage:[UIImage imageNamed:PLACE_HOLDER_PORTRAIT]];
        }
        else{
            _headerImageV.image = [UIImage imageNamed:PLACE_HOLDER_PORTRAIT];
        }
    }
    else{
        self.nameLab.text = @"请先关注老人";
        self.sexImageV.hidden = YES;
        [self.headerImageV setImage:[UIImage imageNamed:PLACE_HOLDER_PORTRAIT]];
    }
    
}

@end
