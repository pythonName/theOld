//
//  TheCarePlanResponseModel.m
//  theOld
//
//  Created by 张欢欢 on 2017/11/23.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "TheCarePlanResponseModel.h"

@implementation TheCarePlanResponseModel

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"data" : [DateModel class]};
}

@end

@implementation DateModel

@end
