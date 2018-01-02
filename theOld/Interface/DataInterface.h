//
//  DataInterface.h
//  VShare
//
//  Created by 胜日公司 on 16/2/25.
//  Copyright © 2016年 胜日公司. All rights reserved.
//

#import "VFNetAPIClient.h"
#import "MainTheOverviewOfCareRequestModel.h"
#import "MainTheOverviewOfCareResponseModel.h"
#import "PhysiologicalRequestModel.h"
#import "PhysiologicalResponseModel.h"
#import "CareOldManSearchRequestModel.h"
#import "CareOldManSearchResponseModel.h"
#import "CareOldManAddDataRequestModel.h"
#import "CareOldManAddDataResponseModel.h"
#import "CarePackagesRequestModel.h"
#import "CarePackagesResponseModel.h"
#import "CareOldManListRequsetModel.h"
#import "CareOldManListResponseModel.h"
#import "TheGuardianListRequestModel.h"
#import "TheGuardianListResponseModel.h"
#import "TheCarePlanRequestModel.h"
#import "TheCarePlanResponseModel.h"
#import "UserCenterRequestModel.h"
#import "UserCenterResponseModel.h"
#import "TheOldAccountRequestModel.h"
#import "TheOldAccountResponseModel.h"
#import "TheOldAccountDetailRequestModel.h"
#import "TheOldAccountDetailResponseModel.h"
#import "ListOfCouponsRequestModel.h"
#import "ListOfCouponsResponseModel.h"
#import "CouponsForRequestModel.h"
#import "CouponsForResponseModel.h"
#import "LogOutCareRequestModel.h"
#import "LogOutCareResponseModel.h"
#import "RealNameInformationRequestModel.h"
#import "RealNameInformationResponseModel.h"
#import "CommonResponseModel.h"


typedef void(^resultDic)(NSDictionary *resultDic);
typedef void(^resultObj)(id obj);
typedef void(^faildur)(NSError *error);
typedef void (^CompleteBlock) (CommonResponseModel *model, NSError *error);

@interface DataInterface : NSObject

+ (instancetype)shareInstance;

//获取验证码
- (void)getMessageCodeRequest: (id)params complication:(resultDic)comlication;

//用户注册
- (void)registerRequest: (id)params complication:(resultDic)comlication;

//用户登录
- (void)loginRequest: (id)params complication:(resultDic)comlication;

//用户登出
- (void)logoutRequest: (id)params complication:(resultDic)comlication;

//根据身份证号查询老人
- (void)searchOldIDRequest: (id)params completeBlock:(CompleteBlock)completeBlock;

//根据身份证号添加关注老人
- (void)addOldRequest: (id)params completeBlock:(CompleteBlock)completeBlock;

//已关注老人列表 首页
- (void)followOldersListRequest: (id)params complication:(resultDic)comlication;

//生理数据 首页
+ (void)physiologicalDataRequest: (id)params complication:(CompleteBlock)completeBlock;

//设备注册
- (void)registerDeviceRequest: (id)params complication:(resultDic)comlication;
//
////上传此udid对应打包过已安装的应用
//- (void)uploadInstalledPackageRequest: (id)params method:(VFNetworkMethod)method complication:(resultDic)comlication;
//
////删除已经打好的包
//- (void)deletePackageRequest: (id)params complication:(resultDic)comlication;

//首页数据请求
+ (void)mainTheOverviewOfCareRequestWithModel:(MainTheOverviewOfCareRequestModel *)model toGetResult:(void (^) (MainTheOverviewOfCareResponseModel *result, NSError *error))completionBlock;

//关注老人列表数据请求
+ (void)careOldManListRequestWithModel:(CareOldManListRequsetModel *)model toGetResult:(void (^) (CareOldManListResponseModel *result, NSError *error))completionBlock;

+ (void)careOldManListRequest:(id)params result:(CompleteBlock)completeBlock;

//关注老人列表--根据身份证查询老人 数据请求
+ (void)careOldManSearchRequestWithModel:(CareOldManSearchRequestModel *)model toGetResult:(void (^) (CareOldManSearchResponseModel *result, NSError *error))completionBlock;

//关注老人列表--- 添加老人数据请求
+ (void)careOldManAddDataRequestWithModel:(CareOldManAddDataRequestModel *)model toGetResult:(void (^) (CareOldManAddDataResponseModel *result, NSError *error))completionBlock;

//照护套餐数据请求
+ (void)carePackagesRequestWithModel:(CarePackagesRequestModel *)model toGetResult:(void (^) (CarePackagesResponseModel *result, NSError *error))completionBlock;

//生理数据请求
+ (void)physiologicalDataRequestWithModel:(PhysiologicalRequestModel *)model toGetResult:(void (^) (PhysiologicalResponseModel *result, NSError *error))completionBlock;

//监护人列表数据请求
+ (void)theGuardianListRequestWithModel:(TheGuardianListRequestModel *)model toGetResult:(void (^) (TheGuardianListResponseModel *result, NSError *error))completionBlock;

//照护计划数据请求
+ (void)theCarePlanRequestWithModel:(TheCarePlanRequestModel *)model toGetResult:(void (^) (TheCarePlanResponseModel *result, NSError *error))completionBlock;

//个人中心数据请求
+ (void)userCenterRequestWithModel:(UserCenterRequestModel *)model toGetResult:(void (^) (UserCenterResponseModel *result, NSError *error))completionBlock;

//老人账户列表数据请求
- (void)theOldAccountRequestWithModel:(TheOldAccountRequestModel *)model toGetResult:(void (^) (TheOldAccountResponseModel *result, NSError *error))completionBlock;

//老人账户详情数据请求
- (void)theOldAccountDetailRequestWithModel:(TheOldAccountDetailRequestModel *)model toGetResult:(void (^) (TheOldAccountDetailResponseModel *result, NSError *error))completionBlock;

//我的优惠券列表数据请求
+ (void)listOfCouponsRequestWithModel:(ListOfCouponsRequestModel *)model toGetResult:(void (^) (ListOfCouponsResponseModel *result, NSError *error))completionBlock;

//我的优惠券兑换数据请求
+ (void)couponsForRequestWithModel:(CouponsForRequestModel *)model toGetResult:(void (^) (CouponsForResponseModel *result, NSError *error))completionBlock;

//退出登录数据请求
+ (void)logOutCareRequestWithModel:(LogOutCareRequestModel *)model toGetResult:(void (^) (LogOutCareResponseModel *result, NSError *error))completionBlock;

//实名信息数据请求
+ (void)realNameInformationRequestWithModel:(RealNameInformationRequestModel *)model toGetResult:(void (^) (id result, NSError *error))completionBlock;

//忘记密码-重新设置密码
+ (void)resetPasswordRequest:(NSDictionary *)param toGetResult:(void(^)(CommonResponseModel *model, NSError *error))completeBlock;

//修改用户密码
+ (void)changePasswordRequest:(NSDictionary *)param result:(void(^)(CommonResponseModel *model, NSError *error))completeBlock;

//校验短信验证码
+(void)verifyCodeRequest:(NSDictionary *)params result:(CompleteBlock)completeBlock;

//获取监护人列表数据
+ (void)guardianListRequest:(NSDictionary *)params result:(CompleteBlock)completeBlock;

//上传用户头像
+ (void)uploadPortraitRequest:(NSDictionary *)params result:(CompleteBlock)completeBlock;

//绑定新的手机号码即用户登录名
+ (void)changePhoneRequest:(NSDictionary *)params result:(CompleteBlock)completeBlock;

//老人照护套餐
+ (void)carePackagesRequest:(NSDictionary *)params result:(CompleteBlock)completeBlock;

@end
