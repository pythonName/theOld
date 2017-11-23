//
//  UserManager.h
//  theOld
//
//  Created by loary on 2017/11/1.
//  Copyright © 2017年 loary. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^resultDic)(NSDictionary *resultDic);

@interface UserManager : NSObject

@property (nonatomic,assign) BOOL isLogined; //是否已登录
@property (nonatomic,copy) NSString *session;
@property (nonatomic,copy) NSString *defaultSelectedOldID;//当前关注的老人ID
@property (nonatomic,copy) NSString *accountStr; //登录账号
@property (nonatomic,copy) NSString *userName; //姓名
//@property (nonatomic,copy) NSString *vshareVersion; //发布时的版本号
//@property (nonatomic,copy) NSString *vshareVersion; //发布时的版本号
//@property (nonatomic,copy) NSString *vshareVersion; //发布时的版本号


+(instancetype)shareInstance;

- (void)loginRequest: (id)params complication:(resultDic)comlication;


@end
