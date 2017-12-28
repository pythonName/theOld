//
//  AppDelegate+ConfigThird.m
//  theOld
//
//  Created by test on 17/12/22.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "AppDelegate+ConfigThird.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "AFNetworkReachabilityManager.h"
#import "UserManager.h"

@implementation AppDelegate (ConfigThird)

- (void)configThirdParty{
    [self configAMap];
    
    [self checkNetwork];
    
    [self checkUserLogin];
}

/**配置高德地图*/
- (void)configAMap{
    [AMapServices sharedServices].apiKey = @"432715e176c08b1d0b9bfcb54ba5075c";
    [AMapServices sharedServices].enableHTTPS = YES;
}

/**检查网络环境*/
- (void)checkNetwork{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                [[Toast makeText:@"网络断开!"] show];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [[Toast makeText:@"无WiFi！"] show];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [[Toast makeText:@"蜂窝网络！"] show];
                break;
            default:
                [[Toast makeText:@"网络断开！"] show];
                break;
        }
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)checkUserLogin{
   UserManager *userManager = [UserManager shareInstance];
    NSLog(@"%@", userManager);
}

@end
