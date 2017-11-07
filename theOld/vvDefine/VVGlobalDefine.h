//
//  VVGlobalDefine.h
//  VShare
//
//  Created by 胜日公司 on 16/2/25.
//  Copyright © 2016年 胜日公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef VVGlobalDefine
#define VVGlobalDefine
extern UIColor *baseColor; //基础色调

extern BOOL isLoggedIn;
extern NSInteger deviceInt;  //设备ID. 1. iPhone,iPod Touch 2. iPad
extern NSInteger iphoneoff; //在iPad上是否显示iphone的应用
extern NSInteger globalJB; //是不是重签名版本.0.正版  1.越狱
extern CGFloat ScreenRatio; //屏幕适配宽度比 基于iphone4
extern CGFloat ScreenHRatioBaseIphone6; //屏幕适配高度比 基于iphone6
extern CGFloat ScreenWRatioBaseIphone6; //屏幕适配宽度比 基于iphone6
extern NSDictionary *countryCodeDic;//匹配到的当前国家区号字典


extern NSString *MessageListPath;
extern NSString *gAppRootPath; //程序根目录
extern NSString *gAppDownloadSavePath; //ipa安装包下载后保存的目录
extern NSString *gAppDownloadResumeCachePath; //保存每个下载的resumeData数据及半截文件的目录
extern NSString *gDownloadPath;//下载保存地址
extern UIImage *cellPlaceHolderImage;
extern NSString *vtproducttype;//产品类型 iPhone3,1
extern NSString *vtdeviceversion; //设备版本 4.3.3
extern NSString *idfaStr;//idfa
extern NSString *udidStr;//udid
extern NSString *openUdidStr;//openUdid
extern NSString *app_Version; //app版本
extern NSString *const LanguageCode;//语言编码，plist文件中
extern NSString *const DiskSpaceDidChange;/**< 磁盘空间发生变化*/
extern NSString *const FileTotalSizeKey;/**< 文件大小的Key*/
extern NSString *tokenStr;           //当前token值
extern NSString *userIDStr;          //当前userID

extern BOOL isPackageHalfQuit;          //打包视图是否中途退出，“是”再次查询不再次请求，“否”再次请求
#endif
