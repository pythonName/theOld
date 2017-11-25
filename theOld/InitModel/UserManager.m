//
//  UserManager.m
//  theOld
//
//  Created by loary on 2017/11/1.
//  Copyright © 2017年 loary. All rights reserved.
//

#import "UserManager.h"
#import "NSObject+Runtime.h"
#import "DataInterface.h"

@implementation UserManager

- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSDictionary *pros = [self properties_aps];
    for(NSString *key in [pros allKeys]) {
        [aCoder encodeObject:[pros objectForKey:key] forKey:key];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        NSArray *arr = [self getAllProperties];
        for(NSString *key in arr) {
            id value = [aDecoder decodeObjectForKey:key];
            if (value)
            [self setValue:value forKey:key];
        }
    }
    
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        NSString *ii = [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"];
        self.isLogined = ([ii isEqualToString:@"yes"] ? YES:NO);
        NSString *session = [[NSUserDefaults standardUserDefaults] objectForKey:@"session"];
        self.session = session.length > 0 ? session : @"";
        NSString *defaultSelectedOldID = [[NSUserDefaults standardUserDefaults] objectForKey:@"defaultSelectedOldID"];
        self.defaultSelectedOldID = defaultSelectedOldID.length > 0 ? defaultSelectedOldID : @"";
    }
    return self;
}

+ (instancetype)shareInstance
{
    static UserManager *shareInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

- (void)setSession:(NSString *)session {
    if(![_session isEqualToString:session]) {
        _session = [session copy];
        [[NSUserDefaults standardUserDefaults] setObject:_session forKey:@"session"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

//重新选择当前关注的老人
- (void)setDefaultSelectedOldID:(NSString *)defaultSelectedOldID {
    if(![_defaultSelectedOldID isEqualToString:defaultSelectedOldID]) {
        _defaultSelectedOldID = [defaultSelectedOldID copy];
        [[NSUserDefaults standardUserDefaults] setObject:_session forKey:@"defaultSelectedOldID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //其他切换操作
    }
}

- (void)loginRequest: (id)params complication:(resultDic)comlication {
    [[DataInterface shareInstance] loginRequest:params complication:^(NSDictionary *resultDic) {
        int code = [[resultDic objectForKey:@"code"] intValue];
        if(200 == code){
            self.isLogined = YES;
            [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"isLogined"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        comlication(resultDic);
    }];
}

@end
