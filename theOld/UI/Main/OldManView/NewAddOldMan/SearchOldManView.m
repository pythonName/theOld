//
//  SearchOldManView.m
//  theOld
//
//  Created by 拓润公司 on 2017/11/8.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "SearchOldManView.h"
#import "UIView+NIB.h"
@implementation SearchOldManView
 

+ (SearchOldManView *)loadSearchOldManView{
    SearchOldManView *vv = (SearchOldManView *)[self loadFromNIB];
    
    return vv;
}

- (void)awakeFromNib {
    [super awakeFromNib];
   self.searchButton.layer.cornerRadius = 45/2;
    
}

@end
