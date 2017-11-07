//
//  LeveyTabBarControllerViewController.h
//  LeveyTabBarController
//
//  Created by Levey Zhu on 12/15/10.
//  Copyright 2010 VanillaTech. All rights reserved.
//

#import "LeveyTabBar.h"

@class UITabBarController;

@protocol LeveyTabBarControllerDelegate;

@interface LeveyTabBarController : UIViewController <LeveyTabBarDelegate>
{
	LeveyTabBar     *_tabBar;
	UIView          *_containerView;
	UIView          *_transitionView;
	NSMutableArray  *_viewControllers;
	NSUInteger      _selectedIndex;
    
	id<LeveyTabBarControllerDelegate> _delegate;
	
	BOOL _tabBarTransparent;
	BOOL _tabBarHidden;
    NSMutableArray *_badgeViewArray; 
    UIColor *_badgeViewBackgroundColor; //badge的背景色
}

@property(nonatomic, copy) NSMutableArray *viewControllers;
@property(nonatomic, readonly) UIViewController *selectedViewController;
@property(nonatomic, assign) NSUInteger selectedIndex;

// Apple is readonly
@property(nonatomic, readonly) LeveyTabBar *tabBar;
@property(nonatomic, assign) id<LeveyTabBarControllerDelegate> delegate;

// Default is NO, if set to YES, content will under tabbar
@property (nonatomic, assign) BOOL tabBarTransparent;
@property (nonatomic, assign) BOOL tabBarHidden;
@property (nonatomic, retain) UIColor *badgeViewBackgroundColor;

- (id)initWithViewControllers:(NSArray *)controllers images:(NSArray *)images;
- (void)hideTabBar:(BOOL)animated;
- (void)showTabBar:(BOOL)animated;
- (void)setBageValue:(NSInteger)value atIndex:(NSInteger)index;
 
@end


@protocol LeveyTabBarControllerDelegate <NSObject>

@optional

- (BOOL)tabBarController:(LeveyTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;
- (void)tabBarController:(LeveyTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;

@end

@interface UIViewController (LeveyTabBarControllerSupport)

@property(nonatomic, retain, readonly) LeveyTabBarController *leveyTabBarController;

@end

