//
//  TheCarePlanResponseModel.h
//  theOld
//
//  Created by 张欢欢 on 2017/11/23.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "YKNetworkBaseModel.h"

@class DateModel;

@interface TheCarePlanResponseModel : YKNetworkBaseModel

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) NSArray<DateModel *> *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface DateModel : NSObject

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *end_time;

@property (nonatomic, copy) NSString *start_time;

@property (nonatomic, copy) NSString *date;

@end

