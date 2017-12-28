//
//  CommonResponseModel.h
//  theOld
//
//  Created by test on 2017/12/27.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "YKNetworkBaseModel.h"

@interface CommonResponseModel : YKNetworkBaseModel

@property (nonatomic, strong) NSNumber *code;
@property (nonatomic, strong) id data;
@property (nonatomic, copy) NSString *msg;

@end
