//
//  MainDataManager.h
//  theOld
//
//  Created by test on 2017/12/29.
//  Copyright © 2017年 loary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CareOldManModel.h"

@interface MainDataManager : NSObject

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic) NSInteger selectIndex;

+ (instancetype)sharedInstance;

- (CareOldManModel *)selectModel;

/**
 清除用户登录数据
 */
- (void)clearData;

/**
 用户登录后没有退出，但是应用被系统kill掉 此时需要缓存老人数据以便下次打开应用的时候显示
 */
- (void)storeCacheData;

/**
 加载用户缓存数据
 */
- (void)loadCacheData;


@end
