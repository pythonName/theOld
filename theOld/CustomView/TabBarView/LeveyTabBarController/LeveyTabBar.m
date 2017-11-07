//
//  LeveyTabBar.m
//  LeveyTabBarController
//
//  Created by Levey Zhu on 12/15/10.
//  Copyright 2010 VanillaTech. All rights reserved.
//

#define DM_TABBAR_SUBVIEW_INDEX_BACKGROUND      0
#define DM_TABBAR_SUBVIEW_INDEX_OFFSET_BUTTON   1
#define DM_TABBAR_MARGIN_MASK                   8

#import <QuartzCore/QuartzCore.h>

#import "LeveyTabBar.h"
#import "TabButton.h"

#import "UIView+Badge.h"
#import "JOBadgeView.h"
//#import "LocalizationSystem.h"


@interface LeveyTabBar() {
    NSArray *_imagesInfo;
    UIImageView *backgroundView;
    UIView *v;
    UILabel *_redDotOfCardP;
}

@end

@implementation LeveyTabBar

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)images
{
    self = [super initWithFrame:frame];
    if(self)
	{
        
        
        _imagesInfo = [images retain];
		backgroundView = [[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
            UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            
            UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
            
            effectview.frame = CGRectMake(0, 0.5, [UIScreen mainScreen].bounds.size.width, backgroundView.frame.size.height-0.5);
            
            [backgroundView addSubview:effectview];
            
            [self setBackgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]];
   
        } else{
            [backgroundView setBackgroundColor:[UIColor whiteColor]];
        }

        v = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 0.5)] autorelease];
        [v setBackgroundColor:[UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1.0]];
        [backgroundView addSubview:v];
		[self addSubview:backgroundView];
		CGFloat tabWidth = self.frame.size.width / [images count];
        
		for (int i = 0; i < [images count]; i++)
		{
            CGRect _fram = CGRectMake(tabWidth*i, 0.5, tabWidth, frame.size.height-0.5);
			TabButton *button = [[[TabButton alloc] initWithFrame:_fram] autorelease];

			button.tag = i;
           
            NSString *title = [[images objectAtIndex:i] objectForKey:@"Title"];
			[button.buttonLabel setText:title];
			[button addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
			[self addSubview:button];
            
		}
    }
    
    return self;
}

- (void)dealloc {
    [_imagesInfo release];
    _imagesInfo  = nil;
    
    [super dealloc];
}

- (void)setBackgroundImage:(UIImage *)image
{
	[backgroundView setImage:image];
}

- (void)tabBarButtonClicked:(id)sender
{
  
        UIButton *button = (UIButton *)sender;
        [self selectTabAtIndex:button.tag];
  	
}

- (void)selectTabAtIndex:(NSInteger)index
{
    NSInteger tabCount = [self.subviews count] - 1;
	for (int i = 0; i < tabCount; i++)
	{
        int buttonIndexInSubViews = i + DM_TABBAR_SUBVIEW_INDEX_OFFSET_BUTTON;
		TabButton *button = (TabButton *)[self.subviews objectAtIndex:buttonIndexInSubViews];
        
        UIImage *img11 = nil;
        UIImage *imgDefault = nil;
        if (_imagesInfo.count == 3) {//马甲
            img11 = [UIImage imageNamed:[[_imagesInfo objectAtIndex:i] objectForKey:@"Seleted"]];
            imgDefault = [UIImage imageNamed:[[_imagesInfo objectAtIndex:i] objectForKey:@"Default"]];
        }else {
            img11 = [UIImage imageNamed:[[_imagesInfo objectAtIndex:i] objectForKey:@"Seleted"]];
            imgDefault = [UIImage imageNamed:[[_imagesInfo objectAtIndex:i] objectForKey:@"Default"]];
        }
        
        if (i == index) {
            button.selected = YES;
            [button selectedStatus];
            [button.buttonImageView setImage:img11];
        }else {
            button.selected = NO;
            [button noSelectedStatus];
            [button.buttonImageView setImage:imgDefault];
        }

	}

    if ([_delegate respondsToSelector:@selector(tabBar:didSelectIndex:)])
    {
		UIButton *button = (UIButton *)[self.subviews objectAtIndex:index + DM_TABBAR_SUBVIEW_INDEX_OFFSET_BUTTON];
        [_delegate tabBar:self didSelectIndex:button.tag];
    }
}

- (void)setBageValue:(NSInteger)value atIndex:(NSInteger)index {
    NSInteger buttonIndexInSubViews = index + DM_TABBAR_SUBVIEW_INDEX_OFFSET_BUTTON;
    UIButton *button = (UIButton *)[self.subviews objectAtIndex:buttonIndexInSubViews];
    JOBadgeView *badgeView = button.badge;
    if (value > 0) {
         badgeView.badgeValue = [NSString stringWithFormat:@"%ld", (long)value];
    }else{
         badgeView.badgeValue = nil;
    }
   
}

@end
