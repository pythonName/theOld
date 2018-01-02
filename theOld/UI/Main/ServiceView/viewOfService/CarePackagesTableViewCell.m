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
}

@end
