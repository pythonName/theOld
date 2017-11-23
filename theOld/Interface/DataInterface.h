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
typedef void(^resultDic)(NSDictionary *resultDic);
typedef void(^resultObj)(id obj);
typedef void(^faildur)(NSError *error);

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
- (void)searchOldIDRequest: (id)params complication:(resultDic)comlication;

//根据身份证号添加关注老人
- (void)addOldRequest: (id)params complication:(resultDic)comlication;

//已关注老人列表 首页
- (void)followOldersListRequest: (id)params complication:(resultDic)comlication;

//生理数据 首页
- (void)physiologicalDataRequest: (id)params complication:(resultDic)comlication;

//设备注册
- (void)registerDeviceRequest: (id)params complication:(resultDic)comlication;
//
////上传此udid对应打包过已安装的应用
//- (void)uploadInstalledPackageRequest: (id)params method:(VFNetworkMethod)method complication:(resultDic)comlication;
//
////删除已经打好的包
//- (void)deletePackageRequest: (id)params complication:(resultDic)comlication;

//测试接口
+ (void)MainTheOverviewOfCareRequestWithModel:(MainTheOverviewOfCareRequestModel *)model toGetResult:(void (^) (MainTheOverviewOfCareResponseModel *result, NSError *error))completionBlock;
@end
