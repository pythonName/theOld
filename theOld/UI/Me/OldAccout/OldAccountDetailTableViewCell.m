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
    
    // numeric list view
    self.listView = [[ECListView alloc] initWithFrame:CGRectMake(12*ScreenHRatioBaseIphone6, 44.0, ScreenWidth-24*ScreenHRatioBaseIphone6, 0.0) listStyle:ListStyleNumbered];
    
    // optional configuration
    self.listView.indentation = 8.0;
    self.listView.itemsSpacing = 10.0;
    self.listView.textColor = UIColorFromRGB(0x666666);//[UIColor darkGrayColor];
    self.listView.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:self.listView];
   
    
}

-(void)refreshUIWithData:(id)data {
    OldAccountDataList *modelData = data;
    NSArray *arr = [modelData.content componentsSeparatedByString:@"\n"];
    
    [self.listView refreshViewWithTextItems:arr];
    self.titleLab.text = modelData.title;
    self.dateLab.text = modelData.end_time;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//续费按钮事件
- (IBAction)renewalBtnClick:(id)sender {
}

@end
