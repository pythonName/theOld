//
//  InfoTableViewCell.m
//  theOld
//
//  Created by 拓润公司 on 2017/11/21.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "InfoTableViewCell.h"

@implementation InfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.whiteView.layer.cornerRadius = 4;
 
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
