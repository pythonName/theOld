//
//  ListOfCouponsResponseModel.m
//  theOld
//
//  Created by 张欢欢 on 2017/11/23.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "ListOfCouponsResponseModel.h"

@implementation ListOfCouponsResponseModel


+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"data" : [CouponListData class]};
}

@end

@implementation CouponListData

@end

