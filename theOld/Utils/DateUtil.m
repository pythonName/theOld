//
//  DateUtil.m
//  theOld
//
//  Created by test on 2018/1/16.
//  Copyright © 2018年 loary. All rights reserved.
//

#import "DateUtil.h"

static NSDateFormatter *dateFormmatter;

static id instance;

@interface DateUtil()
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation DateUtil

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DateUtil alloc] init];
    });
    
    return instance;
}

//日期转换成字符
- (NSString *)stringFromDate:(NSDate *)date formatter:(NSString *)formatter{
    [self.dateFormatter setDateFormat:formatter];
    return [self.dateFormatter stringFromDate:date];
}


- (NSInteger)mothFromDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger calendarFlag = NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps = [calendar components:calendarFlag fromDate:date];
    return [comps month];
}

- (NSInteger)yearFromDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger calendarFlag = NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps = [calendar components:calendarFlag fromDate:date];
    return [comps year];
}

- (NSDateFormatter *)dateFormatter{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    
    return _dateFormatter;
}

@end
