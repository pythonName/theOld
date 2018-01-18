//
//  DateUtil.h
//  theOld
//
//  Created by test on 2018/1/16.
//  Copyright © 2018年 loary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtil : NSObject

+ (instancetype)sharedInstance;

/**
 日期转换成字符
 */
- (NSString *)stringFromDate:(NSDate *)date formatter:(NSString *)formatter;

/**
 获取指定日期的月份
 */
- (NSInteger)mothFromDate:(NSDate *)date;

/**
 获取指定日期的年份
 */
- (NSInteger)yearFromDate:(NSDate *)date;

@end
