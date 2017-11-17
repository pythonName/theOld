//
//  TabButton.m
//  91Market
//
//  Created by apple on 12-8-16.
//  Copyright (c) 2012年 wanglong. All rights reserved.
//

#define kButtonMargin       2.0f
#define kOffsetYImage       -5.0f
#define kOffsetYTitle       12.0f
#define kHeightTitle        10.0f

#import "TabButton.h"
#import "vvDefine.h"
#import "VVGlobalDefine.h"

@interface TabButton() {
    
}

@end

@implementation TabButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xf8f8f8);
 
        _buttonImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 26, 23)];
        _buttonImageView.center = CGPointMake(self.frame.size.width/2, _buttonImageView.center.y);
        [self addSubview:_buttonImageView];
        _buttonImageView.backgroundColor = [UIColor clearColor];
        
        _buttonLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_buttonImageView.frame), frame.size.width, self.frame.size.height-CGRectGetMaxY(_buttonImageView.frame)-5)];
        [_buttonLabel setTextAlignment:NSTextAlignmentCenter];
        [_buttonLabel setTextColor:UIColorFromRGB(0x949494)];//默认没选中的颜色
        
        [_buttonLabel setBackgroundColor:[UIColor clearColor]];
        [_buttonLabel setFont:[UIFont systemFontOfSize:12]];
        [self addSubview:_buttonLabel];
//        _buttonLabel.backgroundColor = [UIColor redColor];
        
        _redPointLabel=[[UILabel alloc] initWithFrame:CGRectMake(35, 5, 10, 10)];
        _redPointLabel.layer.cornerRadius = 5;
        _redPointLabel.layer.masksToBounds = YES;
        [_redPointLabel setBackgroundColor:[UIColor redColor]];
        [self addSubview:_redPointLabel];
        _redPointLabel.hidden = YES;
    }
    
    return self;
}

- (void)selectedStatus {
    [_buttonLabel setTextColor:baseColor];
}

- (void)noSelectedStatus {
//    self.backgroundColor = [UIColor clearColor];
// 
    [_buttonLabel setTextColor:UIColorFromRGB(0x555555)];//默认没选中的颜色
}


@end
