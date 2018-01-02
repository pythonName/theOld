//
//  SearchOldManOfResultView.m
//  theOld
//
//  Created by 拓润公司 on 2017/11/8.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "SearchOldManOfResultView.h"
#import "UIView+NIB.h"
@implementation SearchOldManOfResultView

- (IBAction)addAttentionBtnClick:(id)sender {
}

+ (SearchOldManOfResultView *)loadSearchOldManOfResultView{
    SearchOldManOfResultView *vv = (SearchOldManOfResultView *)[self loadFromNIB];
    
    return vv;
}

- (void)awakeFromNib {
    [super awakeFromNib];
  
    self.addAttentionBtn.layer.cornerRadius = 45/2;
}

- (void)setModel:(CareOldManModel *)model{
    _model = model;
    [self updateUI];
}

- (void)updateUI{
    self.nameLab.text = _model.name;
    self.ageLab.text = [NSString stringWithFormat:@"%ld", _model.age];
    self.sexLba.text = _model.sex;
    self.identLab.text = _model.ID_number;
    
}

@end
