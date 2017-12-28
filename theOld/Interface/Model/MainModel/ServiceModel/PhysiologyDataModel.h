//
//  PhysiologyDataModel.h
//  theOld
//
//  Created by test on 2017/12/28.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "YKNetworkBaseModel.h"

@interface PhysiologyDataModel : YKNetworkBaseModel

@property (nonatomic, copy) NSString *daytime;
@property (nonatomic, copy) NSString *weight;
@property (nonatomic, copy) NSString *temperature;
@property (nonatomic, copy) NSString *heart_rate;
@property (nonatomic, copy) NSString *blood_pressure;
@property (nonatomic, copy) NSString *blood_sugar;
@property (nonatomic, copy) NSString *blood_fat;

@end
