//
//  vvDefine.h
//  cop
//  git test
//  Created by Simon Liu on 3/20/12.
//  Copyright (c) 2012 APPVV.COM. All rights reserved.
//

/********************登录注册*******************************/
#import <UIKit/UIKit.h>
//#import "UIImage+Extension.h"
//#import "UIBarButtonItem+Extension.h"
//#import "UINavigationController+Extension.h"
//定义一个传递点击事件的block类型
typedef void (^callBackBlock)(id sender);
#define VFWeakSelf(type) __weak typeof(type) weak##type = type;
//授权通知
#define AUTHORED_NOTITACATION @"AuthoredNotification"
#define AUTHORED_FIRST_USERSELF @"UsersFirstAuthorizedTheirOwnAccount"
#define AUTHORED_NONFIRST_USERSELF @"UsersNonFirstAuthorizedTheirOwnAccount"
#define AUTHORED_FROM_VSHARE @"UserAuthorizationFromVshare"
#define AUTHORED_UNBIND @"RemoveAuthorization"

#pragma mark - UI配置
// 程序主窗体
#define KeyWindow [UIApplication sharedApplication].keyWindow
#define ScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define ScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
#define SCREEN_SCALE [UIScreen mainScreen].scale

#define MainWidth [UIApplication sharedApplication].keyWindow.frame.size.width
#define MainHeight [UIApplication sharedApplication].keyWindow.frame.size.height

#define StatusBarHeight CGRectGetHeight([UIApplication sharedApplication].statusBarFrame)
#define NavigationBarHeight 44.0
#define TabBarHeight 53.0
#define Clearance 15

#define GADHeight 100 //广告高度
#define NumbersOfTopic 3//首页第3行专题放3个

#define BYTE_TO_MB(byte) ((byte)/1024.0/1024.0)
#define KB_TO_MB(kb) ((kb)/1024.0)
#define BYTE_TO_KB(byte) ((byte)/1024.0)

#define getNoNilObject(value) ((value) != nil ? (value) : @"unKnownValue")

//使用网页格式的色彩值
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define UIColorRGBRetain(r,g,b) [[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1] retain]
#define UIColorRGBRetainCDR(r,g,b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

// add by xf_pan 2015-0109 增加获取下载时需要点击链接数据获取接口
#define VV_Get_ADUrlData [NSString stringWithFormat:@"%@api/adslink", HOST]
/** app版本号*/
#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//判断是否为ipad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#pragma mark - 程序接口

#define TESTHOST @"http://61.155.215.48:5000/" //@"http://sanatorium.appvv.com/"//@"http://192.168.16.241:8899/"//
//#define TESTHOST @"http://61.155.215.48:5001/"
#define HOST @"http://api.apiappvv.com/" //正式环境


#define WISHHOST @"http://61.155.215.46:8064/"
//#define HOST @"http://61.155.215.46:8064/"
#define SearchHOST @"http://search.apiappvv.com/" //搜索正式环境
#define UserHOST @"http://members.vshare.com/" // 用户中心正式环境

#define packageTestHost @"http://61.155.215.46:9527/" //测试
#define packageHost @"http://developer.apiappvv.com/" //提交打包申请的

#pragma mark 信息内容接口
#define VV_JsNewRequest() [NSString stringWithFormat:@"%@%@", HOST, @"api/check_js"]
#define VV_CheckJsOpenNewRequest() [NSString stringWithFormat:@"%@%@", HOST, @"api/check_js_open"]

//客户端更新检测 地址特殊
#define VV_CheckVshareVipRequest @"http://api1.apiappvv.com/api/vip_client_update"

//首页推荐
#define VV_HomePage [NSString stringWithFormat:@"%@api/vip/top_apps", HOST]

//首页最新游戏软件
#define VV_SubCategoryNew [NSString stringWithFormat:@"%@api/app_column", HOST]

//多开应用【第三方app分类】
#define MultiAPP [NSString stringWithFormat:@"%@api/vip/category?", HOST]

#define VV_TopicPage() [NSString stringWithFormat:@"%@%@", HOST, @"api/iphone/app_topic"]//特色专题

#define VV_DetailPageURL  [NSString stringWithFormat:@"%@api/vip/app_detail", HOST]//详情页信息接口

#define VV_APPREFURL  [NSString stringWithFormat:@"%@api/app/related", HOST]//详情页的相关推荐

#define VV_IntegralPage [NSString stringWithFormat:@"%@api/infinite_gold", HOST]//无限金币 vip版的

#define VV_AppManagerPage [NSString stringWithFormat:@"%@api/vip/udid_apps", HOST]//APP管理界面应用

#define VV_TopWish [NSString stringWithFormat:@"%@api/wish_apps", HOST]//top心愿接口

#define VV_FilledWish [NSString stringWithFormat:@"%@api/wish_filled",HOST]//Filled心愿接口

#define VV_VCoinsPage [NSString stringWithFormat:@"%@api/app_point", HOST]//金币应用

#define VV_IntegralSearchResult [NSString stringWithFormat:@"%@api/infinite_gold", HOST]//无限金币搜索结果 vip版

#define vShareIOS9Skills(languageStyle) [NSString stringWithFormat:@"%@api/app/ios9skill?language=%@",HOST,languageStyle]//iOS技能

#define VV_InstallTips(languageStyle) [NSString stringWithFormat:@"http://www.ringtonefans.com/update_guide/?language=%@",languageStyle]//更新安装提示

#define VV_CategoryURL [NSString stringWithFormat:@"%@api/app_genre/list", HOST]// 分类

#define VV_FocusURL [NSString stringWithFormat:@"%@api/iphone/topic_web", HOST]// 专题

#define VV_FocusListURL [NSString stringWithFormat:@"%@api/vip/topic_detail", HOST]// 专题列表

#define VV_searchResult [NSString stringWithFormat:@"%@api/app/search", SearchHOST] //搜索结果

#define VV_Hotwords  [NSString stringWithFormat:@"%@api/hot_word/list",HOST]//热词

#define VV_NEWSearch [NSString stringWithFormat:@"%@api/app/search_prefix",SearchHOST]//时时搜索

#define VV_SubCategory [NSString stringWithFormat:@"%@api/app/list",HOST]//分类的二级界面接口

#define VV_UpdateVshare(UDID,version, ios_ver,channel) [NSString stringWithFormat:@"%@%@?udid=%@&version=%@&ios_ver=%@&channel=%@", HOST , @"api/check_version", UDID,version, ios_ver,channel]//更新vshare   api/check_version?device=1&jb=0&version=1.1.2&language=zh-Hans

#define VV_Equipment() [NSString stringWithFormat:@"%@%@", HOST, @"api/app_collection/app_necessary"]// 装机必备


//检测本机有哪些app需要更新的
#define VV_APPLIST_UPDATE() [NSString stringWithFormat:@"%@%@?", HOST, @"api/app/check_update"]

#define kSegmentedControlHeight 47
//#define kSegmentediPadControlHeight 59
//专题表头高度
#define TOPICHEADER_HEIGHT 150.0f
#define FLIP_ANIMATION_DURATION 0.18f

#define APPCURENTVERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


#ifdef DEBUG  
#   define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define NSLog(...)
#endif


//zh-Hans
#define BACK_IMAGE [UIImage imageNamed:@"back"]
#define BACK_IMAGE_VFRAME CGRectMake(0, 0, 44, 44)
#define BACK_IMAGE_INSETS UIEdgeInsetsMake(0, -20, 0, 20)


//新版本用户登入注册
#define USERHOST @"http://usercenterapi.apiappvv.com"

#define GETVerificationCode   [NSString stringWithFormat:@"%@/get_code",USERHOST]
#define USERRegister          [NSString stringWithFormat:@"%@/user/register",USERHOST]
#define USERLogin             [NSString stringWithFormat:@"%@/login",USERHOST]
#define USERID                [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]
#define USER_TOKEN            [[NSUserDefaults standardUserDefaults] objectForKey:@"userToken"]
#define PASSWORD              [[NSUserDefaults standardUserDefaults] objectForKey:@"password"]
#define USERNAME              [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"]


#define PROGRESS_TIME    30

#define REQUEST_SUCCESS_CODE  200       //网络请求成功标识

#define UPDATE_USER_INFO   @"updateUserINFO"     //用户信息变更时发送通知
#define USER_LOGIN_NOTIFICATION @"userLoginNotification"    //用户登录通知
#define USER_LOGOUT_NOTIFICATION @"userLogoutNotification"  //用户登出通知

#define SELECT_OLDMAN_NOTIFICATION @"selectOldManNotification"  //选择关注老人列表的通知

//定义字体
#define PingFang_SC_Medium  @"PingFang-SC-Medium"

#define PLACE_HOLDER_PORTRAIT @"accountIconDefault.png"

#define DEVICE_IPAD [[[UIDevice currentDevice] model] hasPrefix:@"iPad"]
