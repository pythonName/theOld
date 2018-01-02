//
//  CouponsForResponseModel.h
//  theOld
//
//  Created by 张欢欢 on 2017/11/23.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "YKNetworkBaseModel.h"

@interface CouponsForResponseModel : YKNetworkBaseModel
@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) id  data;

@property (nonatomic, assign) NSInteger code;

@end
