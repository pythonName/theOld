//
//  UIViewController+Common.m
//  theOld
//
//  Created by test on 2017/12/27.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "UIViewController+Common.h"
#import "AppDelegate.h"

@implementation UIViewController (Common)

- (void)showNetworkError{
    [self showInfoMsg:@"网络连接失败，请检查您的网络！"];
}

- (void)showInfoMsg:(NSString *)msg{
    [[Toast makeText:msg] show];
}

- (void)presentViewControllerFromRootController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    UIApplication *application = [UIApplication sharedApplication];
    AppDelegate *appDelegate = (AppDelegate *)application.delegate;
    [appDelegate.window.rootViewController presentViewController:viewControllerToPresent animated:YES completion:nil];
}

@end
