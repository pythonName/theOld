//
//  AppDelegate+ConfigThird.m
//  theOld
//
//  Created by test on 17/12/22.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "AppDelegate+ConfigThird.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

@implementation AppDelegate (ConfigThird)

- (void)configThirdParty{
    [self configAMap];
}

- (void)configAMap{
    [AMapServices sharedServices].apiKey = @"432715e176c08b1d0b9bfcb54ba5075c";
    [AMapServices sharedServices].enableHTTPS = YES;
}

@end
