//
//  DataInterface.h
//  VShare
//
//  Created by 胜日公司 on 16/2/25.
//  Copyright © 2016年 胜日公司. All rights reserved.
//

#import "VFNetAPIClient.h"

typedef void(^resultDic)(NSDictionary *resultDic);
typedef void(^resultObj)(id obj);
typedef void(^faildur)(NSError *error);

@interface DataInterface : NSObject

+ (instancetype)shareInstance;

////更新打包请求
//- (void)postUpdataPackageRequest: (id)params complication:(resultDic)comlication;
//
////上传此udid对应打包过已安装的应用
//- (void)uploadInstalledPackageRequest: (id)params method:(VFNetworkMethod)method complication:(resultDic)comlication;
//
////删除已经打好的包
//- (void)deletePackageRequest: (id)params complication:(resultDic)comlication;

@end
