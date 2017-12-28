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

static UserManager *shareInstance = nil;
+ (instancetype)shareInstance
{
    
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"userManagerData"];
        if (data != nil) {
            UserManager *userManager = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            shareInstance = userManager;
        }
        else{
            shareInstance = [[self alloc] init];
        }
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

#define userManagerKey  @"userManagerKey"
- (void)loginRequest: (id)params complication:(resultDic)comlication {
    [[DataInterface shareInstance] loginRequest:params complication:^(NSDictionary *resultDic) {
        int code = [[resultDic objectForKey:@"code"] intValue];
        if(200 == code){
            self.isLogined = YES;
            NSDictionary *userDict = [[resultDic objectForKey:@"data"] objectForKey:@"user"];
            self.userName = [userDict objectForKey:@"username"];
            self.session = [[resultDic objectForKey:@"data"] objectForKey:@"token"];
            NSLog(@"%@===", self.session);
            self.complete = [[resultDic objectForKey:@"data"] objectForKey:@"complete"];
            self.name = [userDict objectForKey:@"name"];
            self.IDCard = [userDict objectForKey:@"ID_number"];
            self.sex = [userDict objectForKey:@"sex"];
            self.dateTime = [userDict objectForKey:@"datetime"];
            self.photo = [userDict objectForKey:@"photo"];
//            [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"isLogined"];

            NSData *managerData = [NSKeyedArchiver archivedDataWithRootObject:self];
            [[NSUserDefaults standardUserDefaults] setObject:managerData forKey:userManagerKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }
        
        comlication(resultDic);
    }];
}


- (void)resetPassword:(id)params commlication:(CompleteBlock)completeBlock{
    [DataInterface resetPasswordRequest:params toGetResult:^(CommonResponseModel *model, NSError *error) {
        completeBlock(model, error);
    }];
}


- (void)logout{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:userManagerKey];
    self.userName = nil;
    self.name = nil;
    self.IDCard = nil;
    self.sex = nil;
    self.photo = nil;
    self.photo = nil;
    self.isLogined = NO;
    self.dateTime = nil;
    self.session = nil;
    self.complete = nil;
}

@end
