//
//  GuardianModel.h
//  theOld
//
//  Created by test on 2017/12/28.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "YKNetworkBaseModel.h"

@interface GuardianModel : YKNetworkBaseModel

@property (nonatomic, copy) NSString *ID_number;
@property (nonatomic, copy) NSString *datetime;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *relation;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *username;


@end
