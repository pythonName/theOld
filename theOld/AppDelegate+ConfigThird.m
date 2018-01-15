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
#import <AlipaySDK/AlipaySDK.h>
#import "MainDataManager.h"

@implementation AppDelegate (ConfigThird)

- (void)configThirdParty{
    [self configAMap];
    
    [self checkNetwork];
    
    [self checkUserLogin];
    
    //加载缓存数据
    [self loadCacheData];
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
//                [[Toast makeText:@"WiFi！"] show];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
//                [[Toast makeText:@"蜂窝网络！"] show];
                break;
            default:
                [[Toast makeText:@"网络断开！"] show];
                break;
        }
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

//检查用户登录状态
- (void)checkUserLogin{
   UserManager *userManager = [UserManager shareInstance];
    MainDataManager *mainDataManager = [MainDataManager sharedInstance];
    NSLog(@"%@", userManager);
}

//配置支付宝钱包返回URL处理方法
- (void)alipayWithURL:(NSURL *)url{
    //如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            NSLog(@"****Alilpay****** result = %@",resultDic);
        }];
    }
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
        
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            NSLog(@"****Alilpay****** result = %@",resultDic);
        }];
    }
}

//应用进入后台运行，保存需要缓存的数据
- (void)storeCacheData{
    [[MainDataManager sharedInstance] storeCacheData];
}

//加载缓存数据
- (void)loadCacheData{
    [[MainDataManager sharedInstance] loadCacheData];
}

@end
