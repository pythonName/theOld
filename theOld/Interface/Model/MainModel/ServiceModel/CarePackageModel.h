//
//  CarePackageModel.h
//  theOld
//
//  Created by test on 2018/1/2.
//  Copyright © 2018年 loary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKNetworkBaseModel.h"

@interface CarePackageModel : YKNetworkBaseModel

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *updated_time;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *end_time;
@property (nonatomic, copy) NSString *shelf_time;
@property (nonatomic, copy) NSString *editor;
@property (nonatomic) NSInteger user_count;
@property (nonatomic) CGFloat price;
@property (nonatomic) CGFloat pack_progress;
@property (nonatomic) NSInteger effective_days;
@property (nonatomic) NSInteger available;

@end
