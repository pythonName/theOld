//
//  LeveyTabBarControllerViewController.m
//  LeveyTabBarController
//
//  Created by Levey Zhu on 12/15/10.
//  Copyright 2010 VanillaTech. All rights reserved.
//

#import "LeveyTabBarController.h"
#import "LeveyTabBar.h"
#import "UIBadgeView.h"

#define DM_TABBAR_HEIGHT     53.0f

static LeveyTabBarController *leveyTabBarController;

@implementation UIViewController (LeveyTabBarControllerSupport)

- (LeveyTabBarController *)leveyTabBarController
{
	return leveyTabBarController;
}

@end

@interface LeveyTabBarController (private)

- (void)displayViewAtIndex:(NSUInteger)index;

@end

@implementation LeveyTabBarController

@synthesize delegate = _delegate;
@synthesize selectedViewController = _selectedViewController;
@synthesize viewControllers = _viewControllers;
@synthesize selectedIndex = _selectedIndex;
@synthesize tabBarHidden = _tabBarHidden;
@synthesize badgeViewBackgroundColor = _badgeViewBackgroundColor;

#pragma mark -view controller lifecycle

- (id)initWithViewControllers:(NSArray *)controllers images:(NSArray *)images;
{
	self = [super init];
	if(self)
	{
       
		_viewControllers = [[NSMutableArray arrayWithArray:controllers] retain];
        
		_containerView = [[UIView alloc] init];
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
            _containerView.frame = [[UIScreen mainScreen] bounds];
        }else {
            _containerView.frame = [[UIScreen mainScreen] applicationFrame];
        }
		_transitionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, _containerView.frame.size.height - DM_TABBAR_HEIGHT)];
		_transitionView.backgroundColor =  [UIColor clearColor];
		_tabBar = [[LeveyTabBar alloc] initWithFrame:CGRectMake(0, _containerView.frame.size.height - DM_TABBAR_HEIGHT, [UIScreen mainScreen].bounds.size.width, DM_TABBAR_HEIGHT) buttonImages:images];
		_tabBar.delegate = self;
        leveyTabBarController = self;
        _badgeViewArray = [NSMutableArray array];
        for (NSInteger i=0; i < [_viewControllers count]; i++) {
            UIBadgeView *badgeView = [[UIBadgeView alloc] init];
            [_badgeViewArray addObject:badgeView];
            [badgeView release];
        }
       
	}
   // self.view.backgroundColor = [UIColor redColor];
	return self;
}

- (void)loadView 
{
	[super loadView];
	[_containerView addSubview:_transitionView];
	[_containerView addSubview:_tabBar];
	self.view = _containerView;
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
    self.selectedIndex = 0;
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	_tabBar = nil;
	_viewControllers = nil;
}

- (void)dealloc 
{
    _tabBar.delegate = nil;
	[_tabBar release];
    [_containerView release];
    [_transitionView release];
	[_viewControllers release];
     [_badgeViewArray release];
    [_badgeViewBackgroundColor release];
    [super dealloc];
}

#pragma mark - instant methods

- (LeveyTabBar *)tabBar
{
	return _tabBar;
}

- (BOOL)tabBarTransparent
{
	return _tabBarTransparent;
}

- (void)setTabBarTransparent:(BOOL)yesOrNo
{
	if (yesOrNo == YES)
	{
		_transitionView.frame = _containerView.bounds;
	}
	else
	{
		_transitionView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, _containerView.frame.size.height - DM_TABBAR_HEIGHT);
	}
}

- (void)showTabBar:(BOOL)animated;
{
    BOOL alreadyShown = (self.tabBar.frame.origin.y == self.view.frame.size.height - DM_TABBAR_HEIGHT);
    if(!alreadyShown) 
    {
        if (animated == YES)
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3f];
        }
        self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - DM_TABBAR_HEIGHT, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
        if (animated == YES)
        {
            [UIView commitAnimations];
        }
		_transitionView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, _containerView.frame.size.height);
    }
    self.tabBarHidden = NO;
}

- (void)hideTabBar:(BOOL)animated;
{
    BOOL alreadyHidden = (self.tabBar.frame.origin.y == self.view.frame.size.height);
    if(!alreadyHidden) 
    {
        if (animated == YES)
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3f];
        }
        self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + DM_TABBAR_HEIGHT, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
        if (animated == YES)
        {
            [UIView commitAnimations];
        }
		_transitionView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, _containerView.frame.size.height);
    }
    self.tabBarHidden = YES;
}

- (NSUInteger)selectedIndex
{
	return _selectedIndex;
}

- (UIViewController *)selectedViewController
{
    return [_viewControllers objectAtIndex:_selectedIndex];
}

-(void)setSelectedIndex:(NSUInteger)index
{
    [self displayViewAtIndex:index];
    [_tabBar selectTabAtIndex:index];
}

#pragma mark - tabBar delegates

- (void)tabBar:(LeveyTabBar *)tabBar didSelectIndex:(NSInteger)index
{
	[self displayViewAtIndex:index];
}

- (void)setBageValue:(NSInteger)value atIndex:(NSInteger)index {
    [_tabBar setBageValue:value atIndex:index];
}

#pragma mark - Private methods

- (void)displayViewAtIndex:(NSUInteger)index
{
    if ([_delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) 
    {
        if (![_delegate tabBarController:self shouldSelectViewController:[self.viewControllers objectAtIndex:index]])
        {
            return;
        }
    }
   // NSLog(@"self.viewControllers == %@, _selectedIndex== %lu,",self.viewControllers,(unsigned long)_selectedIndex);
    
    UIViewController *currentViewController = [self.viewControllers objectAtIndex:_selectedIndex];
        //NSLog(@"self.viewControllers---> index %lu,",(unsigned long)_selectedIndex);
    UIViewController *targetViewController = [self.viewControllers objectAtIndex:index];

    if (_selectedIndex == index && [[_transitionView subviews] count] != 0) 
    {
 
        return;
    }
    
    _selectedIndex = index;

    [currentViewController viewWillDisappear:NO];   
    [targetViewController viewWillAppear:NO];
	[_transitionView.subviews makeObjectsPerformSelector:@selector(setHidden:) withObject:(id)YES];
    targetViewController.view.hidden = NO;
	targetViewController.view.frame = CGRectMake(0, 0, _transitionView.frame.size.width, [UIScreen mainScreen].bounds.size.height);
	if ([targetViewController.view isDescendantOfView:_transitionView]) 
	{
		[_transitionView bringSubviewToFront:targetViewController.view];
	}
	else
	{
		[_transitionView addSubview:targetViewController.view];
	}
    [currentViewController viewDidDisappear:NO];
    [targetViewController viewDidAppear:NO];

    if ([_delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)]) 
    {
        [_delegate tabBarController:self didSelectViewController:targetViewController];
    }
    
    NSString *page_num = @"";
    
    if (index == 0) {
        page_num = @"1";
    }else if (index == 1){
        return;
    }else if (index == 2){
        page_num = @"7";
    }else if (index == 3){
        return;
    }
  
}

@end
