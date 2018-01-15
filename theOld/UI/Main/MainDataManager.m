//
//  MainDataManager.m
//  theOld
//
//  Created by test on 2017/12/29.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "MainDataManager.h"
#import "UserManager.h"

static MainDataManager *instance;

@implementation MainDataManager

+ (instancetype)sharedInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (CareOldManModel *)selectModel{
    if (self.dataArray.count > self.selectIndex) {
        return [self.dataArray objectAtIndex:_selectIndex];
    }
    return nil;
}

//用户登出时清除缓存数据
- (void)clearData{
    self.dataArray = nil;
    self.selectIndex = 0;
    NSString *path = [self getCacheDataPath];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]) {
        NSError *error;
        [manager removeItemAtPath:path error:&error];
        if (error) {
            NSLog(@"%@", error);
        }
    }
}

/**
 缓存用户数据以便下次打开应用的时候显示
 */
- (void)storeCacheData{
    if ([UserManager shareInstance].isLogined) {
        if(self.dataArray.count > 0){
            if ([NSKeyedArchiver archiveRootObject:self.dataArray toFile:[self getCacheDataPath]]) {
                NSLog(@"缓存数据成功！");
            }
        }
    }
}

//加载用户缓存数据
- (void)loadCacheData{
    if ([UserManager shareInstance].isLogined) {
        self.dataArray = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getCacheDataPath]];
        if (self.dataArray.count) {
            NSLog(@"加载数据成功!");
        }
    }
}

- (NSString *)getCacheDataPath{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [docPath stringByAppendingPathComponent:@"mainData.plist"];
    return path;
}

@end
