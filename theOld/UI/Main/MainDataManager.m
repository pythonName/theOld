//
//  MainDataManager.m
//  theOld
//
//  Created by test on 2017/12/29.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "MainDataManager.h"

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

- (void)clearData{
    self.dataArray = nil;
    self.selectIndex = 0;
}

@end
