//
//  PageTurningView.m
//  MFun
//
//  Created by lee jory on 09-12-23.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#define TOPSCROLLVIEW_HEIGHT 32.0
#define INIT_TOPSCROLLVIEW_LABEL(thisLabel) \
        [thisLabel setFrame:CGRectMake(0, 0, self.frame.size.width/_pageCount, TOPSCROLLVIEW_HEIGHT)];\
        thisLabel.textAlignment = UITextAlignmentCenter;\
        thisLabel.font = [UIFont systemFontOfSize:12];\
        thisLabel.backgroundColor = [UIColor clearColor];\
        thisLabel.textColor = [UIColor colorWithRed:66.0 / 255.0 green:66.0 / 255.0 blue:66.0 / 255.0 alpha:1.0];\
        thisLabel.userInteractionEnabled = YES

#import "PageTurningView.h"
#import "CommanSwitchBar.h"
#import "VVGlobalDefine.h"

@interface PageTurningView()<CommanSwitchBarDelegate>{
	NSInteger _curentIndex;
    UIScrollView *_scrollView;
    //UIScrollView *_topScrollView;
    CommanSwitchBar *_topSwitchBar;

    NSArray *_viewControllersInfo;
    NSMutableArray *_viewControllers;

    NSInteger _pageCount;
}

@property (nonatomic,weak) id delegateM;

- (UIViewController *)lookingForController:(NSInteger)index;

@end

@implementation PageTurningView

#pragma mark init method

- (id)initWithFrame:(CGRect)frame withViewControllers:(NSArray *)viewControllersInfo delegate:(id)delegate{
	self = [super initWithFrame:frame];
	if (self != nil) { 
 
        self.backgroundColor = UIColorFromRGB(0xf8f8f8);//[UIColor whiteColor];
        self.delegateM = delegate;
        _curentIndex = 0;
        _pageCount = [viewControllersInfo count];

        
        _viewControllersInfo = [[NSArray alloc] initWithArray:viewControllersInfo];
        _viewControllers = [[NSMutableArray alloc] init];
        
        _topSwitchBar = [[CommanSwitchBar alloc] initWithInfo:viewControllersInfo frame:CGRectMake(0, 0, frame.size.width, kSegmentedControlHeight*ScreenHRatioBaseIphone6)];
        _topSwitchBar.delegateC = self;
        _topSwitchBar.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kSegmentedControlHeight*ScreenHRatioBaseIphone6, frame.size.width, frame.size.height - kSegmentedControlHeight*ScreenHRatioBaseIphone6)];
		_scrollView.contentSize = CGSizeMake(frame.size.width * [viewControllersInfo count],frame.size.height  - kSegmentedControlHeight*ScreenHRatioBaseIphone6);//预置3页的宽度
		_scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
       
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
        [self addSubview:_topSwitchBar];
        [self addSubview:_scrollView];

	}
	return self;
}

- (void)setupScrollViewScroll:(BOOL)bl {
    _scrollView.scrollEnabled = bl;
}

- (void)layoutSubviews {//特为search页面 键盘弹出时视图的大小改变而设置
    [super layoutSubviews];
    _scrollView.contentSize = CGSizeMake(self.frame.size.width * _pageCount,self.frame.size.height  - kSegmentedControlHeight*ScreenHRatioBaseIphone6);
}

- (void)setCurrentVC:(NSInteger)index
{
    _curentIndex = index;
    [_topSwitchBar selectTab:index];
}

#pragma mark public method 

- (void)contentViewWillAppear:(BOOL)animated {
    UIViewController *currentViewController = [self lookingForController:_curentIndex];
    [currentViewController viewWillAppear:animated];
}    
- (void)contentViewDidAppear:(BOOL)animated {
    UIViewController *currentViewController = [self lookingForController:_curentIndex];
    [currentViewController viewDidAppear:animated];
}   
- (void)contentViewWillDisappear:(BOOL)animated {
    UIViewController *currentViewController = [self lookingForController:_curentIndex];
    [currentViewController viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
} 
- (void)contentViewDidDisappear:(BOOL)animated {
    UIViewController *currentViewController = [self lookingForController:_curentIndex];
    [currentViewController viewDidDisappear:animated];
}

#pragma mark UIScrollViewDelegate method

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView == _scrollView)//多个scrollview联动
    {
 
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    _curentIndex = floor(scrollView.contentOffset.x / self.frame.size.width);
    
    if(_curentIndex >=0 && _curentIndex < _pageCount)
        [_topSwitchBar selectTab:_curentIndex];

}

-(void)switchBarClicked:(NSInteger) buttonIndex {
    _curentIndex = buttonIndex;
    [self layoutViews:buttonIndex];
    if (self.delegateM && [self.delegateM respondsToSelector:@selector(switchBarClicked:)]) {
        [self.delegateM switchBarClicked:buttonIndex];
    }
}

#pragma mark private method

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)layoutViews:(NSInteger)index{
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width*index, 0) animated:NO];
    [self layoutCurrent:index];
}

- (void)layoutCurrent:(NSInteger)index{
   
    UIViewController *currentViewController = [self lookingForController:index];

    if (currentViewController == nil) {
        NSDictionary *dicViewInfo = [_viewControllersInfo objectAtIndex:index];
        NSDictionary *param = [dicViewInfo objectForKey:@"Param"];
        currentViewController = [[NSClassFromString([dicViewInfo objectForKey:@"ClassName"]) alloc] initWithFrame:_scrollView.bounds];
        
        if ([currentViewController respondsToSelector:@selector(setupDelegate:)]) {
            [currentViewController performSelector:@selector(setupDelegate:) withObject:self.delegateM];
        }
        if (param!=nil && [currentViewController respondsToSelector:@selector(setupParam:)]) {
            [currentViewController performSelector:@selector(setupParam:) withObject:param];
        }
        
        NSDictionary *_currentViewInfo = [[NSDictionary alloc] initWithObjectsAndKeys:currentViewController,[NSString stringWithFormat:@"%ld",(long)index], nil];
        
        [_viewControllers addObject:_currentViewInfo];
    }

    currentViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight ;
    [_scrollView addSubview:currentViewController.view];
}
 
- (UIViewController *)lookingForController:(NSInteger)index {
    UIViewController *viewController = nil;
    for(NSDictionary *dic in _viewControllers) {
        viewController = [dic objectForKey:[NSString stringWithFormat:@"%ld",(long)index]];
        if (viewController != nil) {
            break;
        }
    }
    return viewController;
}

@end
