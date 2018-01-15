//
//  AppDelegate.m
//  theOld
//
//  Created by loary on 2017/10/30.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "AppDelegate.h"
#import "VVConfig.h"
#import "vvDefine.h"
#import "MainViewController.h"
#import "CustomNavigationController.h"
#import "CarePlanViewController.h"
#import "MeViewController.h"
#import "LeveyTabBarController.h"

#import "AppDelegate+ConfigThird.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[VVConfig shareInstance] initialization];
    
    sleep(2);
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    [self loadiPhone_Controller];
    
    //配置第三方库
    [self configThirdParty];
    
    return YES;
}

static NSString *kKeyTitle = @"title";
static NSString *kKeyViewControllerClass = @"controllerClass";
static NSString *kKeyIconNormal = @"icon-normal";
static NSString *kKeyIconSelected = @"icon-selected";
static NSString *kKeyNeedNavigationWrapper = @"needNavigationWrapper";
- (void)loadiPhone_Controller{
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 7.0) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }

    NSMutableArray *controllers = [NSMutableArray array];
    NSMutableArray *tabItemInfoArray = [NSMutableArray array];
    //1.
    UIViewController *mainController = [[MainViewController alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - StatusBarHeight - NavigationBarHeight - TabBarHeight)];
    
    CustomNavigationController *mainNavController = [[CustomNavigationController alloc] initWithRootViewController:mainController];
    [controllers addObject:mainNavController];
    
    NSMutableDictionary *tabItemInfo1 = [NSMutableDictionary dictionaryWithCapacity:3];
    [tabItemInfo1 setObject:@"oldPic.png" forKey:@"Default"];
    [tabItemInfo1 setObject:@"oldPic_s.png" forKey:@"Seleted"];
    [tabItemInfo1 setObject: @"关爱老人"forKey:@"Title"];
    [tabItemInfoArray addObject:tabItemInfo1];
    
    //2.
    UIViewController *appsViewController = [[CarePlanViewController alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - StatusBarHeight - NavigationBarHeight - TabBarHeight)];
    
    CustomNavigationController *appNavController = [[CustomNavigationController alloc] initWithRootViewController:appsViewController];
    [controllers addObject:appNavController];
    
    NSMutableDictionary *tabItemInfo2 = [NSMutableDictionary dictionaryWithCapacity:3];
    
    [tabItemInfo2 setObject:@"CarePlanPic.png" forKey:@"Default"];
    [tabItemInfo2 setObject:@"CarePlanPic_s.png" forKey:@"Seleted"];
    [tabItemInfo2 setObject:@"照护计划" forKey:@"Title"];
    [tabItemInfoArray addObject:tabItemInfo2];
    
    
    //3.
    UIViewController *pasController = [[MeViewController alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - StatusBarHeight - NavigationBarHeight - TabBarHeight)];
    
    CustomNavigationController *pasNavController = [[CustomNavigationController alloc] initWithRootViewController:pasController];
    [controllers addObject:pasNavController];
    
    NSMutableDictionary *tabItemInfo3 = [NSMutableDictionary dictionaryWithCapacity:3];
    [tabItemInfo3 setObject:@"MePicture.png" forKey:@"Default"];
    [tabItemInfo3 setObject:@"MePicture_s.png" forKey:@"Seleted"];
    [tabItemInfo3 setObject:@"我的" forKey:@"Title"];
    [tabItemInfoArray addObject:tabItemInfo3];
    
    LeveyTabBarController *tabBarController = [[LeveyTabBarController alloc] initWithViewControllers:controllers images:tabItemInfoArray];
    
    
    [self.window addSubview:tabBarController.view];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    //支付宝钱包返回URL处理方法
    [self alipayWithURL:url];
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
    //保存需要缓存的数据
    [self storeCacheData];
}

- (void)applicationWillTerminate:(UIApplication *)application{
}

@end
