//
//  LeveyTabBar.h
//  LeveyTabBarController
//
//  Created by Levey Zhu on 12/15/10.
//  Copyright 2010 VanillaTech. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol LeveyTabBarDelegate;

@interface LeveyTabBar : UIView
{
	id<LeveyTabBarDelegate> _delegate;
    UIView                  *_maskLayerView;
}

@property (nonatomic, assign) id<LeveyTabBarDelegate> delegate;

- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)images;
- (void)selectTabAtIndex:(NSInteger)index;
- (void)setBackgroundImage:(UIImage *)image;
- (void)setBageValue:(NSInteger)value atIndex:(NSInteger)index;

@end

@protocol LeveyTabBarDelegate<NSObject>

@optional
- (void)tabBar:(LeveyTabBar *)tabBar didSelectIndex:(NSInteger)index;

@end
