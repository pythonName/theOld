//
//  UserManager.h
//  theOld
//
//  Created by loary on 2017/11/1.
//  Copyright © 2017年 loary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonResponseModel.h"

typedef void(^resultDic)(NSDictionary *resultDic);
typedef void(^CompleteBlock) (CommonResponseModel *model, NSError *error);

@interface UserManager : NSObject <NSCoding>

@property (nonatomic,assign) BOOL isLogined; //是否已登录
@property (nonatomic,copy) NSString *session;   //用户登录凭证，发起请求时封装到请求头信息里面
@property (nonatomic,copy) NSString *defaultSelectedOldID;//当前关注的老人ID
@property (nonatomic,copy) NSString *accountStr; //登录账号
@property (nonatomic,copy) NSString *userName; //姓名
@property (nonatomic, copy) NSString *name;     //昵称
@property (nonatomic, copy) NSString *IDCard;   //省份证
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *dateTime;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *complete;

//@property (nonatomic,copy) NSString *vshareVersion; //发布时的版本号
//@property (nonatomic,copy) NSString *vshareVersion; //发布时的版本号
//@property (nonatomic,copy) NSString *vshareVersion; //发布时的版本号


+(instancetype)shareInstance;

- (void)loginRequest: (id)params complication:(resultDic)comlication;

/**登出*/
- (void)logout;

/**重置密码*/
- (void)resetPassword:(id)params commlication:(CompleteBlock)completeBlock;


@end
