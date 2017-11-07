//
//  TabButton.h
//  91Market
//
//  Created by apple on 12-8-16.
//  Copyright (c) 2012年 wanglong. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface TabButton : UIButton

@property(nonatomic, copy) UIImageView * buttonImageView;
@property(nonatomic, retain)  UILabel* buttonLabel;
@property(nonatomic, retain)  UILabel* redPointLabel;

- (void)selectedStatus;
- (void)noSelectedStatus;

@end
