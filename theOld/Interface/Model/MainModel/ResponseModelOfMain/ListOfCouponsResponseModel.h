//
//  ListOfCouponsResponseModel.h
//  theOld
//
//  Created by 张欢欢 on 2017/11/23.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "YKNetworkBaseModel.h"

@class CouponListData;

@interface ListOfCouponsResponseModel : YKNetworkBaseModel

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) NSArray<CouponListData *> *data;

@property (nonatomic, assign) NSInteger code;

@end

@interface CouponListData : NSObject

@property (nonatomic, copy) NSString *editor;

@property (nonatomic, copy) NSString *end_time;

@property (nonatomic, copy) NSString *number;

@property (nonatomic, assign) NSInteger available;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, copy) NSString *start_time;

@property (nonatomic, assign) NSInteger greater_than;

@property (nonatomic, copy) NSString *updated_time;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *username;

@end

