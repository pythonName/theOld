//
//  HeaderOfMainView.m
//  theOld
//
//  Created by 拓润公司 on 2017/11/8.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "HeaderOfMainView.h"
#import "UIView+NIB.h"
@implementation HeaderOfMainView

+ (HeaderOfMainView *)loadHeaderOfMainView{
    HeaderOfMainView *vv = (HeaderOfMainView *)[self loadFromNIB];
    
    return vv;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.resouseButton.layer.cornerRadius = 10;
    
}

//老人资料卡
- (IBAction)gotoResouseButtonClick:(id)sender {
    
}
@end
