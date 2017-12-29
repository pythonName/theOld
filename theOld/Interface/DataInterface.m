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

- (void)searchOldIDRequest: (id)params complication:(resultDic)comlication {
    NSString *requestUrl = [NSString stringWithFormat:@"%@api/select-olders/",TESTHOST];
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestUrl withParams:params withMethodType:Post successBlock:^(id value) {
        comlication(value);
    } failureBlock:^(id value) {
        comlication(nil);
    }];
}

- (void)addOldRequest: (id)params complication:(resultDic)comlication {
    NSString *requestUrl = [NSString stringWithFormat:@"%@api/add-attention/",TESTHOST];
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestUrl withParams:params withMethodType:Post successBlock:^(id value) {
        comlication(value);
    } failureBlock:^(id value) {
        comlication(nil);
    }];
}

- (void)followOldersListRequest: (id)params complication:(resultDic)comlication {
    NSString *requestUrl = [NSString stringWithFormat:@"%@api/homepage/",TESTHOST];
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestUrl withParams:params withMethodType:Get successBlock:^(id value) {
        comlication(value);
    } failureBlock:^(id value) {
        comlication(nil);
    }];
}

+ (void)physiologicalDataRequest: (id)params complication:(CompleteBlock)completeBlock {
    NSString *requestUrl = [self requestStrWithPath:@"api/physiological-data/"];
    
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestUrl withParams:params withMethodType:Get successBlock:^(id value) {
        completeBlock([CommonResponseModel covertToModelWithDict:value], nil);
    } failureBlock:^(id value) {
        completeBlock(nil, value);
    }];
}


- (void)registerDeviceRequest: (id)params complication:(resultDic)comlication {
    NSString *requestUrl = @"http://open.umtrix.com/h/skkaN/device/reg_device";
    NSDictionary *dic = @{@"av":@1,
                          @"device_sn":@"Ay0000000000002107UM",
                          @"store_id":@1009,
                          @"store_name":@"李大叔",
                          @"area":@"深圳市"
                          };
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestUrl withParams:dic withMethodType:Get successBlock:^(id value) {
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
//首页数据请求
+ (void)mainTheOverviewOfCareRequestWithModel:(MainTheOverviewOfCareRequestModel *)model toGetResult:(void (^) (MainTheOverviewOfCareResponseModel *result, NSError *error))completionBlock{
    
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


//关注老人列表数据请求
+ (void)careOldManListRequestWithModel:(CareOldManListRequsetModel *)model toGetResult:(void (^) (CareOldManListResponseModel *result, NSError *error))completionBlock{
    NSString *requestUrl = [NSString stringWithFormat:@"%@api/logout/",TESTHOST];
    id params = @"";
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestUrl withParams:params withMethodType:Get successBlock:^(id value) {
        CareOldManListResponseModel *response = [CareOldManListResponseModel covertToModelWithDict:value];
        completionBlock(response,nil);
    } failureBlock:^(id value) {
        completionBlock(nil,value);
    }];
    
}


//关注老人列表--根据身份证查询老人 数据请求
+ (void)careOldManSearchRequestWithModel:(CareOldManSearchRequestModel *)model toGetResult:(void (^) (CareOldManSearchResponseModel *result, NSError *error))completionBlock{
    NSString *requestUrl = [NSString stringWithFormat:@"%@api/logout/",TESTHOST];
    id params = @"";
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestUrl withParams:params withMethodType:Get successBlock:^(id value) {
        CareOldManSearchResponseModel *response = [CareOldManSearchResponseModel covertToModelWithDict:value];
        completionBlock(response,nil);
    } failureBlock:^(id value) {
        completionBlock(nil,value);
    }];
    
}


//关注老人列表--- 添加老人数据请求
+ (void)careOldManAddDataRequestWithModel:(CareOldManAddDataRequestModel *)model toGetResult:(void (^) (CareOldManAddDataResponseModel *result, NSError *error))completionBlock{
    NSString *requestUrl = [NSString stringWithFormat:@"%@api/logout/",TESTHOST];
    id params = @"";
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestUrl withParams:params withMethodType:Get successBlock:^(id value) {
        CareOldManAddDataResponseModel *response = [CareOldManAddDataResponseModel covertToModelWithDict:value];
        completionBlock(response,nil);
    } failureBlock:^(id value) {
        completionBlock(nil,value);
    }];
    
}


//照护套餐数据请求
+ (void)carePackagesRequestWithModel:(CarePackagesRequestModel *)model toGetResult:(void (^) (CarePackagesResponseModel *result, NSError *error))completionBlock{
    NSString *requestUrl = [NSString stringWithFormat:@"%@api/logout/",TESTHOST];
    id params = @"";
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestUrl withParams:params withMethodType:Get successBlock:^(id value) {
        CarePackagesResponseModel *response = [CarePackagesResponseModel covertToModelWithDict:value];
        completionBlock(response,nil);
    } failureBlock:^(id value) {
        completionBlock(nil,value);
    }];
    
}


//生理数据请求
+ (void)physiologicalDataRequestWithModel:(PhysiologicalRequestModel *)model toGetResult:(void (^) (PhysiologicalResponseModel *result, NSError *error))completionBlock{
    NSString *requestUrl = [NSString stringWithFormat:@"%@api/logout/",TESTHOST];
    id params = @"";
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestUrl withParams:params withMethodType:Get successBlock:^(id value) {
        PhysiologicalResponseModel *response = [PhysiologicalResponseModel covertToModelWithDict:value];
        completionBlock(response,nil);
    } failureBlock:^(id value) {
        completionBlock(nil,value);
    }];
    
}


//监护人列表数据请求
+ (void)theGuardianListRequestWithModel:(TheGuardianListRequestModel *)model toGetResult:(void (^) (TheGuardianListResponseModel *result, NSError *error))completionBlock{
    NSString *requestUrl = [NSString stringWithFormat:@"%@api/logout/",TESTHOST];
    id params = @"";
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestUrl withParams:params withMethodType:Get successBlock:^(id value) {
        TheGuardianListResponseModel *response = [TheGuardianListResponseModel covertToModelWithDict:value];
        completionBlock(response,nil);
    } failureBlock:^(id value) {
        completionBlock(nil,value);
    }];
    
}

//照护计划数据请求
+ (void)theCarePlanRequestWithModel:(TheCarePlanRequestModel *)model toGetResult:(void (^) (TheCarePlanResponseModel *result, NSError *error))completionBlock {
    NSString *requestUrl = [NSString stringWithFormat:@"%@api/logout/",TESTHOST];
    id params = @"";
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestUrl withParams:params withMethodType:Get successBlock:^(id value) {
        TheCarePlanResponseModel *response = [TheCarePlanResponseModel covertToModelWithDict:value];
        completionBlock(response,nil);
    } failureBlock:^(id value) {
        completionBlock(nil,value);
    }];
}

//个人中心数据请求
+ (void)userCenterRequestWithModel:(UserCenterRequestModel *)model toGetResult:(void (^) (UserCenterResponseModel *result, NSError *error))completionBlock{
    NSString *requestUrl = [NSString stringWithFormat:@"%@api/logout/",TESTHOST];
    id params = @"";
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestUrl withParams:params withMethodType:Get successBlock:^(id value) {
        UserCenterResponseModel *response = [UserCenterResponseModel covertToModelWithDict:value];
        completionBlock(response,nil);
    } failureBlock:^(id value) {
        completionBlock(nil,value);
    }];
}


//老人账户列表数据请求
- (void)theOldAccountRequestWithModel:(TheOldAccountRequestModel *)model toGetResult:(void (^) (TheOldAccountResponseModel *result, NSError *error))completionBlock{
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@api/old_pack/",TESTHOST];
    id params = [TheOldAccountRequestModel covertToDictWithModelObject:model];

    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestUrl withParams:params withMethodType:Get successBlock:^(id value) {
        TheOldAccountResponseModel *response = [TheOldAccountResponseModel covertToModelWithDict:value];
        completionBlock(response,nil);
    } failureBlock:^(id value) {
        completionBlock(nil,value);
    }];
}


//老人账户详情数据请求
- (void)theOldAccountDetailRequestWithModel:(TheOldAccountDetailRequestModel *)model toGetResult:(void (^) (TheOldAccountDetailResponseModel *result, NSError *error))completionBlock{
    NSString *requestUrl = [NSString stringWithFormat:@"%@api/logout/",TESTHOST];
    id params = @"";
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestUrl withParams:params withMethodType:Get successBlock:^(id value) {
        TheOldAccountDetailResponseModel *response = [TheOldAccountDetailResponseModel covertToModelWithDict:value];
        completionBlock(response,nil);
    } failureBlock:^(id value) {
        completionBlock(nil,value);
    }];
}


//我的优惠券列表数据请求
+ (void)listOfCouponsRequestWithModel:(ListOfCouponsRequestModel *)model toGetResult:(void (^) (ListOfCouponsResponseModel *result, NSError *error))completionBlock{
    NSString *requestUrl = [NSString stringWithFormat:@"%@api/logout/",TESTHOST];
    id params = @"";
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestUrl withParams:params withMethodType:Get successBlock:^(id value) {
        ListOfCouponsResponseModel *response = [ListOfCouponsResponseModel covertToModelWithDict:value];
        completionBlock(response,nil);
    } failureBlock:^(id value) {
        completionBlock(nil,value);
    }];
}


//我的优惠券兑换数据请求
+ (void)couponsForRequestWithModel:(CouponsForRequestModel *)model toGetResult:(void (^) (CouponsForResponseModel *result, NSError *error))completionBlock{
    NSString *requestUrl = [NSString stringWithFormat:@"%@api/logout/",TESTHOST];
    id params = @"";
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestUrl withParams:params withMethodType:Get successBlock:^(id value) {
        CouponsForResponseModel *response = [CouponsForResponseModel covertToModelWithDict:value];
        completionBlock(response,nil);
    } failureBlock:^(id value) {
        completionBlock(nil,value);
    }];
}


//退出登录数据请求
+ (void)logOutCareRequestWithModel:(LogOutCareRequestModel *)model toGetResult:(void (^) (LogOutCareResponseModel *result, NSError *error))completionBlock{
    NSString *requestUrl = [NSString stringWithFormat:@"%@api/logout/",TESTHOST];
    id params = @"";
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestUrl withParams:params withMethodType:Get successBlock:^(id value) {
        LogOutCareResponseModel *response = [LogOutCareResponseModel covertToModelWithDict:value];
        completionBlock(response,nil);
    } failureBlock:^(id value) {
        completionBlock(nil,value);
    }];
}

//实名信息数据请求
+ (void)realNameInformationRequestWithModel:(RealNameInformationRequestModel *)model toGetResult:(void (^) (id result, NSError *error))completionBlock{
    NSString *requestUrl = [NSString stringWithFormat:@"%@api/perfect-information/",TESTHOST];
    id params = [RealNameInformationRequestModel covertToDictWithModelObject:model];
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestUrl withParams:params withMethodType:Post successBlock:^(id value) {
//        RealNameInformationResponseModel *response = [RealNameInformationResponseModel covertToModelWithDict:value];
        completionBlock(value,nil);
    } failureBlock:^(id value) {
        completionBlock(nil,value);
    }];
}

+ (void)resetPasswordRequest:(NSDictionary *)param toGetResult:(void (^)(CommonResponseModel *, NSError *))completeBlock{
    NSString *requestURL = [NSString stringWithFormat:@"%@api/forget-password/", TESTHOST];
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestURL withParams:param withMethodType:Post successBlock:^(id value) {
        completeBlock([CommonResponseModel covertToModelWithDict:value], nil);
    } failureBlock:^(id value) {
        completeBlock(nil, value);
    }];
}

+ (void)changePasswordRequest:(NSDictionary *)param result:(void (^)(CommonResponseModel *, NSError *))completeBlock{
    NSString *requestStr = [NSString stringWithFormat:@"%@api/change-password/", TESTHOST];
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestStr withParams:param withMethodType:Post successBlock:^(id value) {
        completeBlock([CommonResponseModel covertToModelWithDict:value], nil);
    } failureBlock:^(id value) {
        completeBlock(nil, value);
    }];
    
}

+ (NSString *)requestStrWithPath:(NSString *)path{
    return [NSString stringWithFormat:@"%@%@", TESTHOST, path];
}

+ (NSString *)requestStrWithPath:(NSString *)path params:(NSDictionary *)params{
    NSString *requestUrl = [self requestStrWithPath:path];
    NSArray *keys = [params allKeys];
    requestUrl = [requestUrl stringByAppendingString:@"?"];
    for (NSString *key in keys) {
        requestUrl = [requestUrl stringByAppendingString:[NSString stringWithFormat:@"%@=%@", key, [params objectForKey:key]]];
    }
    return requestUrl;
}

+ (void)careOldManListRequest:(id)params result:(CompleteBlock)completeBlock{
    NSString *requestStr = [self requestStrWithPath:@"api/get_focus/"];
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestStr withParams:nil withMethodType:Get successBlock:^(id value) {
        completeBlock([CommonResponseModel covertToModelWithDict:value], nil);
    } failureBlock:^(id value) {
        completeBlock(nil, value);
    }];
}

+ (void)verifyCodeRequest:(NSDictionary *)params result:(CompleteBlock)completeBlock{
    NSString *requestStr = [self requestStrWithPath:@"api/judge_confirm/"];
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestStr withParams:params withMethodType:Post successBlock:^(id value) {
        completeBlock([CommonResponseModel covertToModelWithDict:value], nil);
    } failureBlock:^(id value) {
        completeBlock(nil, value);
    }];
}

//获取监护人列表数据
+ (void)guardianListRequest:(NSDictionary *)params result:(CompleteBlock)completeBlock{
    NSString *requestStr = [self requestStrWithPath:@"api/get_guars/" params:params];
    
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestStr withParams:nil withMethodType:Get successBlock:^(id value) {
        completeBlock([CommonResponseModel covertToModelWithDict:value], nil);
    } failureBlock:^(id value) {
        completeBlock(nil, value);
    }];
}

+ (void)uploadPortraitRequest:(NSDictionary *)params result:(CompleteBlock)completeBlock{
    NSString *requestStr = [self requestStrWithPath:@"api/upload_pic"];
    [[VFNetAPIClient netWorkClient] requestJsonDataWithPath:requestStr withParams:params withMethodType:Post successBlock:^(id value) {
        
    } failureBlock:^(id value) {
        
    }];
}

@end
