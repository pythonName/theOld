//
//  CarePlanModel.h
//  theOld
//
//  Created by test on 2018/1/16.
//  Copyright © 2018年 loary. All rights reserved.
//

#import "YKNetworkBaseModel.h"

@interface CarePlanModel : YKNetworkBaseModel

@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *start_time;
@property (nonatomic, copy) NSString *end_time;
@property (nonatomic, copy) NSString *content;

@end
