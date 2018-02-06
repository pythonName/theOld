//
//  VVConfig.m
//  VShare
//
//  Created by 胜日公司 on 16/2/25.
//  Copyright © 2016年 胜日公司. All rights reserved.
//

#import "VVConfig.h"
#import "UserManager.h"

@interface VVConfig() {

}

@end

@implementation VVConfig

//如果同时重写getter和setter方法，会报“_isOpenLocalPush 该变量没有定义的错误” 需要加下面这句话
//@synthesize isOpenLocalPush = _isOpenLocalPush;

- (id)init {
    self = [super init];
    if (self) {
        self.vshareVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        id ff = [[NSUserDefaults standardUserDefaults] objectForKey:@"isOpenLocalPush"];
        if (nil != ff) {
            _isOpenLocalPush = [ff boolValue];
        }else {
            _isOpenLocalPush = YES;
        }
        
    }
    return self;
}

+ (instancetype)shareInstance
{
    static VVConfig *shareInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

- (void)initialization {//顺序啊
    [self setupEnvironment];
    [UserManager shareInstance];
  //  [[LoginManager shareInstance] verifyHasLoggedIn];
}

- (void)setupEnvironment {
    if ([[[UIDevice currentDevice] model] hasPrefix:@"iPhone"]
        || [[[UIDevice currentDevice] model] hasPrefix:@"iPod"]) {
        deviceInt=1;
        //ScreenRatio = ScreenWidth/320;
        //以6的标准来比例
        ScreenWRatioBaseIphone6 = ScreenWidth/375;
        ScreenHRatioBaseIphone6 = ScreenHeight/667;
        /*
         设备         逻辑分辨率(宽x高，编码中所用的数值)     设备分辨率     scale
         4(s)               320x480                     640x960        @2x
         5(s、c)            320x568                     640x1136        @2x
         6\7\8              375x667                     750x1334        @2x
         6+\7+\8+           414x736                     1080x1920       @3x

         */
        
    }
    else if ([[[UIDevice currentDevice] model] hasPrefix:@"iPad"]){
        ScreenWRatioBaseIphone6 = ScreenWidth/375;
        ScreenHRatioBaseIphone6 = 1;
    }
//    else{
//        deviceInt=2;
//        //ScreenRatio = ScreenWidth/768;
//        ScreenHRatioBaseIphone6 = ScreenHeight/1024;
//        ScreenWRatioBaseIphone6 = ScreenWidth/768;
//    }
    
    vtdeviceversion=[[NSString alloc] initWithString:[[UIDevice currentDevice] systemVersion]];
    vtproducttype=[[NSString alloc] initWithString:[[UIDevice currentDevice] model]];
    baseColor = UIColorFromRGB(0x8dc21f);
}

@end
