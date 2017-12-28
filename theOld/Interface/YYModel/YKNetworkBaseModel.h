//
//  YKNetworkBaseModel.h
//  YiKu
//
//  Created by WuChuMing on 17/3/31.
//  Copyright © 2017年 ZhaoShang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKNetworkBaseModel : NSObject


/**
 *  MODEL转字典
 *
 *  @param Obj 模型
 *
 *  @return 字典
 */
+ (NSDictionary *)covertToDictWithModelObject:(id)Obj;
/**
 *  字典转MODEL
 *
 *  @param dict 字典
 *
 *  @return 模型
 */
+ (instancetype)covertToModelWithDict:(NSDictionary *)dict;
/**
 *  模型转JSON
 *
 *  @param Obj 模型
 *
 *  @return 返回JSON字符串
 */
+ (NSString *)toJsonStringWithModel:(id)Obj;

+ (NSMutableArray *)covertToArrayWithDictArray:(NSArray *)array;
@end
