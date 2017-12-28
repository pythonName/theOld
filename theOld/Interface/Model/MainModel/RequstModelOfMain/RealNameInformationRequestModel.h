//
//  RealNameInformationRequestModel.h
//  theOld
//
//  Created by 张欢欢 on 2017/11/23.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "YKNetworkBaseModel.h"

@interface RealNameInformationRequestModel : YKNetworkBaseModel

@property (nonatomic, copy) NSString *name;     //昵称
@property (nonatomic, copy) NSString *sex;      //性别
@property (nonatomic, copy) NSString *ID_number;    //身份证

@end
