//
//  UIViewController+Common.h
//  theOld
//
//  Created by test on 2017/12/27.
//  Copyright © 2017年 loary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Common)

/**显示网络错误*/
- (void)showNetworkError;

/**显示一般提示信息*/
- (void)showInfoMsg:(NSString *)msg;

- (void)presentViewControllerFromRootController:(UIViewController *)viewControllerToPresent  animated:(BOOL)flag completion:(void (^)(void))completion;

@end
