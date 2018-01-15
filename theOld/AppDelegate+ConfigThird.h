//
//  AppDelegate+ConfigThird.h
//  theOld
//
//  Created by test on 17/12/22.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (ConfigThird)

/**配置第三方库*/
- (void)configThirdParty;

/**配置高德地图*/
- (void)configAMap;

/**检查用户登录状态*/
- (void)checkUserLogin;

/*配置支付宝钱包返回URL处理方法**/
- (void)alipayWithURL:(NSURL *)url;

/**
 保存需要缓存的数据
 */
- (void)storeCacheData;

/**
 加载缓存数据
 */
- (void)loadCacheData;

@end
