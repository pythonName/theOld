//
//  CareOldManModel.h
//  theOld
//
//  Created by test on 2017/12/27.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "YKNetworkBaseModel.h"

@interface CareOldManModel : YKNetworkBaseModel <NSCoding>

@property (nonatomic, copy) NSString *ID_number;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *cell_phone;
@property (nonatomic, copy) NSString *fix_phone;
@property (nonatomic) NSInteger is_delete;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *pack_progress;    //服务进度
@property (nonatomic,assign) NSInteger count;  //监护人数量
@property (nonatomic,assign) NSInteger age;//

@end

 
