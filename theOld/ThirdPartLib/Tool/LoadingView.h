//
//  LoadingView.h
//  theOld
//
//  Created by 张欢欢 on 2017/11/21.
//  Copyright © 2017年 loary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

+ (LoadingView*)showCirleInView:(UIView *)view;

+ (void)showCirleView;
+(void)hideLoadingView;

@end
