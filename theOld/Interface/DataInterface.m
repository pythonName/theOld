//
//  DataInterface.m
//  VShare
//
//  Created by 胜日公司 on 16/2/25.
//  Copyright © 2016年 胜日公司. All rights reserved.
//

#import "DataInterface.h"
#import "VVGlobalDefine.h"
#import "vvDefine.h"
//#import "JSONKit.h"
#import "AFURLResponseSerialization.h"

#define CodeRequestCom(URL,PRA,METHOD,COMLICATION) \
    NSMutableDictionary *commonPra = [self getCommonRequestParams:PRA]; \
\
    NSMutableString *str = [NSMutableString stringWithString:@"?"];\
    NSArray * allkeys = [commonPra allKeys];\
    for (int i = 0; i < allkeys.count; i++)\
    {\
        NSString * key = [allkeys objectAtIndex:i];\
        id obj  = [commonPra objectForKey:key];\
        [str appendString:[NSString stringWithFormat:@"%@=%@&",key,obj]];\
    }\
    NSLog(@"请求的接口---%@%@",URL,str);\
\
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:URL withParams:commonPra withMethodType:METHOD successBlock:^(id value) {    \
    COMLICATION(value); \
    } failureBlock:^(id value) {    \
        COMLICATION(nil);   \
    }];

@interface DataInterface() {
    AFHTTPSessionManager *_manager;
}

@end

@implementation DataInterface

+ (instancetype)shareInstance
{
    static DataInterface *shareInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

- (void)getMessageCodeRequest: (id)params complication:(resultDic)comlication {
    NSString *requestUrl = [NSString stringWithFormat:@"%@api/confirme/",TESTHOST];
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestUrl withParams:params withMethodType:Post successBlock:^(id value) {
        comlication(value);
    } failureBlock:^(id value) {
        comlication(nil);
    }];
}

- (void)registerRequest: (id)params complication:(resultDic)comlication {
    NSString *requestUrl = [NSString stringWithFormat:@"%@api/regist/",TESTHOST];
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestUrl withParams:params withMethodType:Post successBlock:^(id value) {
        comlication(value);
    } failureBlock:^(id value) {
        comlication(nil);
    }];
}

- (void)loginRequest: (id)params complication:(resultDic)comlication {
    NSString *requestUrl = [NSString stringWithFormat:@"%@api/login/",TESTHOST];
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestUrl withParams:params withMethodType:Post successBlock:^(id value) {
        comlication(value);
    } failureBlock:^(id value) {
        comlication(nil);
    }];
}

- (void)logoutRequest: (id)params complication:(resultDic)comlication {
    NSString *requestUrl = [NSString stringWithFormat:@"%@api/logout/",TESTHOST];
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestUrl withParams:params withMethodType:Get successBlock:^(id value) {
        comlication(value);
    } failureBlock:^(id value) {
        comlication(nil);
    }];
}

//- (NSMutableDictionary *)getCommonRequestParams:(NSDictionary *)pra {
//    NSMutableDictionary *dp = [NSMutableDictionary dictionary];
//    if (nil != pra) {
//        [dp addEntriesFromDictionary:pra];
//    }
//
//    NSString *udidDis = @"";
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DistributionConfig" ofType:@"plist"];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
//        NSDictionary *chanDict=[NSDictionary dictionaryWithContentsOfFile:filePath];
//        udidDis = [chanDict objectForKey:@"udid"];
//    }
//
//    NSDictionary *common = @{@"device" : getNoNilObject([NSNumber numberWithInteger:deviceInt]),
//                             @"language": getNoNilObject([LocalizationSystem sharedLocalSystem].languageCode),
//                             @"jb" : getNoNilObject([NSNumber numberWithInteger:globalJB]),
//                             @"udid" : getNoNilObject(udidDis),
//                             @"from" : @"vspro"
//                             };
//    [dp addEntriesFromDictionary:common];
//
//    return dp;
//}
//
//- (void)postUpdataPackageRequest: (id)params complication:(resultDic)comlication{
//    NSString *requestUrl = [NSString stringWithFormat:@"%@api/iosupdateipa",packageHost];
//    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestUrl withParams:params withMethodType:Post successBlock:^(id value) {
//        comlication(value);
//    } failureBlock:^(id value) {
//        comlication(nil);
//    }];
//}
//
//- (void)uploadInstalledPackageRequest: (id)params method:(VFNetworkMethod)method complication:(resultDic)comlication {
//    NSString *requestUrl = [NSString stringWithFormat:@"%@api/ioscollectapp",packageHost];
//    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestUrl withParams:params withMethodType:method successBlock:^(id value) {
//        comlication(value);
//    } failureBlock:^(id value) {
//        comlication(nil);
//    }];
//}
//
//- (void)deletePackageRequest: (id)params complication:(resultDic)comlication {
//    NSString *requestUrl = [NSString stringWithFormat:@"%@api/iosdeleteapp",packageHost];
//    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestUrl withParams:params withMethodType:Post successBlock:^(id value) {
//        comlication(value);
//    } failureBlock:^(id value) {
//        comlication(nil);
//    }];
//}
//测试接口
+ (void)MainTheOverviewOfCareRequestWithModel:(MainTheOverviewOfCareRequestModel *)model toGetResult:(void (^) (MainTheOverviewOfCareResponseModel *result, NSError *error))completionBlock{
    
//    NSDictionary *postDict = [MainTheOverviewOfCareRequestModel covertToDictWithModelObject:model];
    NSString *requestUrl = [NSString stringWithFormat:@"%@api/logout/",TESTHOST];
    id params = @"";
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestUrl withParams:params withMethodType:Get successBlock:^(id value) {
        MainTheOverviewOfCareResponseModel *response = [MainTheOverviewOfCareResponseModel covertToModelWithDict:value];
        completionBlock(response,nil);
    } failureBlock:^(id value) {
        completionBlock(nil,value);
    }];
    
    
}
@end
