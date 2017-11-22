//
//  YKNetworkBaseModel.m
//  YiKu
//
//  Created by WuChuMing on 17/3/31.
//  Copyright © 2017年 ZhaoShang. All rights reserved.
//

#import "YKNetworkBaseModel.h"
#import "YYModel.h"

@implementation YKNetworkBaseModel

+ (NSDictionary *)covertToDictWithModelObject:(id)Obj
{
    return [Obj yy_modelToJSONObject];
}

+ (instancetype)covertToModelWithDict:(NSDictionary *)dict
{
    return [self yy_modelWithDictionary:dict];

}

+ (NSString *)toJsonStringWithModel:(id)Obj
{
    return [Obj yy_modelToJSONString];
}


//重写以下几个方法（归档方法）
- (void)encodeWithCoder:(NSCoder*)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder*)aDecoder{
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}

- (id)copyWithZone:(NSZone*)zone {
    return [self yy_modelCopy];
}

- (NSUInteger)hash {
    return [self yy_modelHash];
}

- (BOOL)isEqual:(id)object {
    return [self yy_modelIsEqual:object];
}

@end
