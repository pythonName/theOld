//
//  CarePackagesTableViewCell.m
//  theOld
//
//  Created by test on 2018/1/2.
//  Copyright © 2018年 loary. All rights reserved.
//

#import "CarePackagesTableViewCell.h"
#import "ECListView.h"

@interface CarePackagesTableViewCell()
@property (weak, nonatomic) IBOutlet ECListView *contentListView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *progressNumber;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end


@implementation CarePackagesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
        _contentListView.indentation = 8.0;
        _contentListView.itemsSpacing = 10.0;
        _contentListView.textColor = [UIColor darkGrayColor];
        _contentListView.font = [UIFont systemFontOfSize:12.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(CarePackageModel *)model{
    _model = model;
    
    [self updateUI];
}

- (void)updateUI{
    self.titleLabel.text = _model.title;
//    [self.contentListView refreshViewWithTextItems:@[_model.content]];
    self.contentLabel.text = _model.content;
    self.startDateLabel.text = _model.start_time;
    self.endDateLabel.text = _model.end_time;
    float progress = _model.pack_progress / 100;
    if (progress > 1.0) {
        progress = (float)(arc4random() % 100) / 100;
    }
    self.progressView.progress = progress;
    
    UIButton *button = [self.contentView viewWithTag:101];
    if (button) {
        [button removeFromSuperview];
    }
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = 101;
    button.titleLabel.font = [UIFont fontWithName:PingFang_SC_Medium size:12.0];
    [button setBackgroundImage:[UIImage imageNamed:@"progressImage.png"] forState:UIControlStateNormal];
    [button setTitle:[NSString stringWithFormat:@"%.0f%%", progress * 100] forState:UIControlStateNormal];
    [self.bottomView addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView).with.offset((ScreenWidth - 32) *progress - 19);
        make.bottom.equalTo(self.progressView.mas_top).with.offset(-2);
        make.size.mas_equalTo(CGSizeMake(38, 20 ));
    }];
    
}

@end
