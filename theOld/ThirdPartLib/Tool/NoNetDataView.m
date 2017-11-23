//
//  NoNetDataView.m
//  theOld
//
//  Created by 张欢欢 on 2017/11/21.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "NoNetDataView.h"
#import "UIView+NIB.h"

@implementation NoNetDataView

+ (NoNetDataView *)loadNoNetDataView{
    NoNetDataView *vv = (NoNetDataView *)[self loadFromNIB];
    
    return vv;
}

+ (NoNetDataView *)loadNoDataViewWithSuccess {
    NoNetDataView *vv = (NoNetDataView *)[self loadFromNIB];
    [vv resetUIView];
    return vv;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)resetUIView {
    self.imageV.image = [UIImage imageNamed:@"loadingNoData.png"];
    self.descriptionLab.text = @"无数据的视图";
}

@end
