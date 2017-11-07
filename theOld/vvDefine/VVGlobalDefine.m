//
//  VVGlobalDefine.m
//  VShare
//
//  Created by lizhenzhen on 16/3/3.
//  Copyright © 2016年 胜日公司. All rights reserved.
//

#import "VVGlobalDefine.h"
UIColor *baseColor = nil;

BOOL isLoggedIn = 0;
NSInteger deviceInt = 0;
NSInteger iphoneoff = 1;
NSInteger globalJB = 0;
CGFloat ScreenRatio = 0;//1.171875
CGFloat ScreenHRatioBaseIphone6 = 0;//1.1034...
CGFloat ScreenWRatioBaseIphone6 = 0;//1.104....

NSDictionary *countryCodeDic = nil;
NSString *MessageListPath = @"";
NSString *gAppRootPath = @"";
NSString *gAppDownloadSavePath = @"";
NSString *gAppDownloadResumeCachePath = @"";
NSString *gDownloadPath = @"";
UIImage *cellPlaceHolderImage = nil;
NSString *vtproducttype = @"";//产品类型 iPhone3,1
NSString *vtdeviceversion = @"";
NSString *idfaStr= @"";
NSString *udidStr = @"";
NSString *openUdidStr=@"";
NSString *app_Version = @"";
NSString *const DiskSpaceDidChange = @"DiskSpaceDidChange";
NSString *const FileTotalSizeKey = @"FileTotalSizeKey";
NSString *const LanguageCode = @"LanguageCode";
NSString *tokenStr = @"";
NSString *userIDStr = @"";

BOOL isPackageHalfQuit = 0;
