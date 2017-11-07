//
//  VVConfig.h
//  VShare
//
//  Created by 胜日公司 on 16/2/25.
//  Copyright © 2016年 胜日公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VVGlobalDefine.h"

@interface VVConfig : NSObject

@property (nonatomic,copy) NSString *vshareVersion; //发布时的版本号
@property (nonatomic,assign) BOOL isOpenLocalPush; //是否打开本地推送

+(instancetype)shareInstance;

- (void)initialization;

@end
