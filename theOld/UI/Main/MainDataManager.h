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

- (void)clearData;

@end
