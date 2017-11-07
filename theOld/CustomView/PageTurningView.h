//
//  PageTurningView.h
//  MFun
//
//  Created by lee jory on 09-12-23.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

@protocol PageTurningViewDelegate <NSObject>

-(void)switchBarClicked:(NSInteger) buttonIndex;

@end

@interface PageTurningView : UIView<UIScrollViewDelegate> {
    
}

- (id)initWithFrame:(CGRect)frame withViewControllers:(NSArray *)viewControllersInfo delegate:(id)delegate;
- (void)setupScrollViewScroll:(BOOL)bl;

- (void)contentViewWillAppear:(BOOL)animated;    
- (void)contentViewDidAppear:(BOOL)animated;
- (void)contentViewWillDisappear:(BOOL)animated; 
- (void)contentViewDidDisappear:(BOOL)animated;
- (UIViewController *)lookingForController:(NSInteger)index;
- (void)setCurrentVC:(NSInteger)index;

@end
